import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/vehicle_data.dart';
import '../../domain/services/obd_service.dart';

// OBD Service Provider
final obdServiceProvider = Provider<OBDService>((ref) {
  return MockOBDService(); // Use mock service for demo
});

// Connection State Provider
final connectionStateProvider =
    StateNotifierProvider<ConnectionStateNotifier, OBDConnectionState>((ref) {
      return ConnectionStateNotifier(ref.watch(obdServiceProvider));
    });

// Vehicle Data Provider
final vehicleDataProvider = StreamProvider<VehicleData?>((ref) {
  final obdService = ref.watch(obdServiceProvider);
  return obdService.dataStream;
});

// Current Vehicle Data Provider (for latest data)
final currentVehicleDataProvider =
    StateNotifierProvider<CurrentVehicleDataNotifier, VehicleData?>((ref) {
      return CurrentVehicleDataNotifier(ref);
    });

class OBDConnectionState {
  final bool isConnected;
  final bool isConnecting;
  final String? connectedDeviceName;
  final String? errorMessage;

  OBDConnectionState({
    this.isConnected = false,
    this.isConnecting = false,
    this.connectedDeviceName,
    this.errorMessage,
  });

  OBDConnectionState copyWith({
    bool? isConnected,
    bool? isConnecting,
    String? connectedDeviceName,
    String? errorMessage,
  }) {
    return OBDConnectionState(
      isConnected: isConnected ?? this.isConnected,
      isConnecting: isConnecting ?? this.isConnecting,
      connectedDeviceName: connectedDeviceName ?? this.connectedDeviceName,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ConnectionStateNotifier extends StateNotifier<OBDConnectionState> {
  final OBDService _obdService;

  ConnectionStateNotifier(this._obdService) : super(OBDConnectionState());

  Future<void> connect(String deviceAddress, String deviceName) async {
    state = state.copyWith(isConnecting: true, errorMessage: null);

    try {
      final success = await _obdService.connect(deviceAddress);
      if (success) {
        state = state.copyWith(
          isConnected: true,
          isConnecting: false,
          connectedDeviceName: deviceName,
        );
      } else {
        state = state.copyWith(
          isConnecting: false,
          errorMessage: 'Failed to connect to device',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isConnecting: false,
        errorMessage: 'Connection error: $e',
      );
    }
  }

  Future<void> disconnect() async {
    try {
      await _obdService.disconnect();
      state = OBDConnectionState();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Disconnect error: $e');
    }
  }
}

class CurrentVehicleDataNotifier extends StateNotifier<VehicleData?> {
  final Ref _ref;

  CurrentVehicleDataNotifier(this._ref) : super(null) {
    // Listen to vehicle data stream
    _ref.listen(vehicleDataProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data != null) {
            state = data;
          }
        },
        loading: () {},
        error: (error, stackTrace) {},
      );
    });
  }
}
