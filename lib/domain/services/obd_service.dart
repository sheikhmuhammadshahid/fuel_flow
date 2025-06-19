import 'dart:async';
import 'dart:math';

import '../../data/models/vehicle_data.dart';
import '../entities/obd_command.dart';

abstract class OBDService {
  Stream<VehicleData> get dataStream;
  Future<bool> connect(String deviceAddress);
  Future<void> disconnect();
  bool get isConnected;
  Future<OBDResponse?> sendCommand(OBDCommand command);
}

class MockOBDService implements OBDService {
  bool _isConnected = false;
  Timer? _dataTimer;
  final StreamController<VehicleData> _dataController =
      StreamController<VehicleData>.broadcast();
  final Random _random = Random();

  @override
  Stream<VehicleData> get dataStream => _dataController.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  Future<bool> connect(String deviceAddress) async {
    await Future.delayed(
      const Duration(seconds: 2),
    ); // Simulate connection delay

    _isConnected = true;
    _startDataGeneration();
    return true;
  }

  @override
  Future<void> disconnect() async {
    _isConnected = false;
    _dataTimer?.cancel();
    _dataTimer = null;
  }

  @override
  Future<OBDResponse?> sendCommand(OBDCommand command) async {
    if (!_isConnected) return null;

    await Future.delayed(
      const Duration(milliseconds: 100),
    ); // Simulate response delay

    switch (command) {
      case OBDCommand.speed:
        return OBDResponse(
          command: command,
          rawData:
              '41 0D ${_generateSpeed().toInt().toRadixString(16).padLeft(2, '0')}',
          parsedValue: _generateSpeed(),
          unit: 'km/h',
          timestamp: DateTime.now(),
        );

      case OBDCommand.rpm:
        final rpm = _generateRPM();
        final rpmHex = (rpm * 4).toInt();
        final a = (rpmHex ~/ 256).toRadixString(16).padLeft(2, '0');
        final b = (rpmHex % 256).toRadixString(16).padLeft(2, '0');
        return OBDResponse(
          command: command,
          rawData: '41 0C $a $b',
          parsedValue: rpm,
          unit: 'rpm',
          timestamp: DateTime.now(),
        );

      case OBDCommand.fuelLevel:
        final level = _generateFuelLevel();
        final levelHex = ((level * 255) / 100)
            .toInt()
            .toRadixString(16)
            .padLeft(2, '0');
        return OBDResponse(
          command: command,
          rawData: '41 2F $levelHex',
          parsedValue: level,
          unit: '%',
          timestamp: DateTime.now(),
        );

      default:
        return null;
    }
  }

  void _startDataGeneration() {
    _dataTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isConnected) {
        final data = VehicleData(
          timestamp: DateTime.now(),
          speed: _generateSpeed(),
          rpm: _generateRPM(),
          engineTemp: _generateEngineTemp(),
          fuelLevel: _generateFuelLevel(),
          batteryVoltage: _generateBatteryVoltage(),
          throttlePosition: _generateThrottlePosition(),
          fuelPressure: _generateFuelPressure(),
          coolantTemp: _generateCoolantTemp(),
          intakeAirTemp: _generateIntakeAirTemp(),
          maf: _generateMAF(),
          fuelTrimShort: _generateFuelTrim(),
          fuelTrimLong: _generateFuelTrim(),
          errorCodes: [],
          vin: 'WBA3A5G59CNP26082', // Sample VIN
        );

        _dataController.add(data);
      }
    });
  }

  double _generateSpeed() {
    // Generate realistic speed values (0-120 km/h)
    return _random.nextDouble() * 120;
  }

  double _generateRPM() {
    // Generate realistic RPM values (800-6000)
    return 800 + (_random.nextDouble() * 5200);
  }

  double _generateEngineTemp() {
    // Generate realistic engine temperature (80-95°C)
    return 80 + (_random.nextDouble() * 15);
  }

  double _generateFuelLevel() {
    // Generate fuel level (slowly decreasing over time)
    final baseLevel = 68.0; // Starting level
    final variation = (_random.nextDouble() - 0.5) * 2; // ±1% variation
    return (baseLevel + variation).clamp(0, 100);
  }

  double _generateBatteryVoltage() {
    // Generate realistic battery voltage (12.0-14.4V)
    return 12.0 + (_random.nextDouble() * 2.4);
  }

  double _generateThrottlePosition() {
    // Generate throttle position (0-100%)
    return _random.nextDouble() * 100;
  }

  double _generateFuelPressure() {
    // Generate fuel pressure (2.5-4.0 bar)
    return 2.5 + (_random.nextDouble() * 1.5);
  }

  double _generateCoolantTemp() {
    // Generate coolant temperature (80-95°C)
    return 80 + (_random.nextDouble() * 15);
  }

  double _generateIntakeAirTemp() {
    // Generate intake air temperature (15-35°C)
    return 15 + (_random.nextDouble() * 20);
  }

  double _generateMAF() {
    // Generate mass air flow (1-25 g/s)
    return 1 + (_random.nextDouble() * 24);
  }

  double _generateFuelTrim() {
    // Generate fuel trim (-10% to +10%)
    return (_random.nextDouble() - 0.5) * 20;
  }

  void dispose() {
    _dataTimer?.cancel();
    _dataController.close();
  }
}
