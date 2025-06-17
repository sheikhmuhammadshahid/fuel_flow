import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../services/fuel_service.dart';

class OBDModel extends ChangeNotifier {
  final OBDFullService _obdService = OBDFullService();
  OBDData? obdData;
  String connectionStatus = "Disconnected";
  String errorMessage = "";
  List<BluetoothDevice> discoveredDevices = [];
  bool? _isBluetoothEnabled;
  bool get isBluetoothEnabled => _isBluetoothEnabled ?? false;
  StreamSubscription<BluetoothAdapterState>? _bluetoothStateSubscription;
  startListening() {
    _bluetoothStateSubscription ??= FlutterBluePlus.adapterState.listen((
      state,
    ) {
      if (state == BluetoothAdapterState.on) {
        _isBluetoothEnabled = true;
        notifyListeners();
      } else if (state == BluetoothAdapterState.off) {
        _isBluetoothEnabled = false;
        notifyListeners();
      }
    });
  }

  Future<void> scan(BuildContext context) async {
    try {
      connectionStatus = "Scanning...";
      notifyListeners();
      discoveredDevices = await _obdService.scanForBluetoothDevices();
      connectionStatus = "";
      notifyListeners();
      await showModalBottomSheet(
        context: context,
        builder: (_) {
          return SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: discoveredDevices.length,
              itemBuilder: (context, index) {
                final device = discoveredDevices[index];
                final deviceName = _obdService.getDeviceDisplayName(device);
                final deviceInfo = _obdService.getDeviceInfo(device);
                final deviceId = device.remoteId.str;

                return ListTile(
                  title: Text(deviceName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('ID: $deviceId'),
                      if (deviceInfo?.rssi != null)
                        Text(
                          'Signal: ${deviceInfo!.rssi} dBm',
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  leading: const Icon(Icons.bluetooth),
                  onTap: () {
                    connect(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        },
      );
      // await refreshData();
    } catch (e) {
      // connectionStatus = "Disconnected";
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  connect(int index) async {
    try {
      connectionStatus = "Connecting...";
      notifyListeners();
      await _obdService.connectToSelectedDevice(discoveredDevices[index]);
      connectionStatus = "Connected";
      await refreshData();
    } catch (e) {
      connectionStatus = "Disconnected";
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> refreshData() async {
    try {
      obdData = await _obdService.readAllOBDData();
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> clearDtcCodes() async {
    try {
      await _obdService.clearDtcCodes();
      await refreshData();
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> disconnect() async {
    try {
      await _obdService.disconnect();
      connectionStatus = "Disconnected";
      obdData = null;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void changeBluetoothState() async {
    await FlutterBluePlus.turnOn();
  }
}
