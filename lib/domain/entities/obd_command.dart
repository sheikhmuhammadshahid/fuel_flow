enum OBDCommand {
  speed('010D', 'Vehicle Speed'),
  rpm('010C', 'Engine RPM'),
  engineTemp('0105', 'Engine Coolant Temperature'),
  fuelLevel('012F', 'Fuel Tank Level Input'),
  throttlePosition('0111', 'Throttle Position'),
  fuelPressure('010A', 'Fuel Pressure'),
  batteryVoltage('0142', 'Control Module Voltage'),
  intakeAirTemp('010F', 'Intake Air Temperature'),
  maf('0110', 'Mass Air Flow Rate'),
  fuelTrimShort('0106', 'Short Term Fuel Trim'),
  fuelTrimLong('0107', 'Long Term Fuel Trim'),
  dtcCodes('03', 'Diagnostic Trouble Codes'),
  vin('0902', 'Vehicle Identification Number');

  const OBDCommand(this.pid, this.description);

  final String pid;
  final String description;
}

class OBDResponse {
  final OBDCommand command;
  final String rawData;
  final dynamic parsedValue;
  final String? unit;
  final DateTime timestamp;

  OBDResponse({
    required this.command,
    required this.rawData,
    required this.parsedValue,
    this.unit,
    required this.timestamp,
  });
}

class OBDParser {
  static OBDResponse parseResponse(OBDCommand command, String response) {
    final timestamp = DateTime.now();

    switch (command) {
      case OBDCommand.speed:
        final value = _parseSpeed(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: 'km/h',
          timestamp: timestamp,
        );

      case OBDCommand.rpm:
        final value = _parseRPM(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: 'rpm',
          timestamp: timestamp,
        );

      case OBDCommand.engineTemp:
        final value = _parseTemperature(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: '°C',
          timestamp: timestamp,
        );

      case OBDCommand.fuelLevel:
        final value = _parseFuelLevel(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: '%',
          timestamp: timestamp,
        );

      case OBDCommand.throttlePosition:
        final value = _parseThrottlePosition(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: '%',
          timestamp: timestamp,
        );

      case OBDCommand.batteryVoltage:
        final value = _parseBatteryVoltage(response);
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: value,
          unit: 'V',
          timestamp: timestamp,
        );

      default:
        return OBDResponse(
          command: command,
          rawData: response,
          parsedValue: response,
          timestamp: timestamp,
        );
    }
  }

  static double? _parseSpeed(String response) {
    try {
      // Response format: 41 0D XX (where XX is the speed in km/h)
      final parts = response.split(' ');
      if (parts.length >= 3) {
        final speedHex = parts[2];
        return int.parse(speedHex, radix: 16).toDouble();
      }
    } catch (e) {
      print('Error parsing speed: $e');
    }
    return null;
  }

  static double? _parseRPM(String response) {
    try {
      // Response format: 41 0C XX YY (where RPM = ((XX * 256) + YY) / 4)
      final parts = response.split(' ');
      if (parts.length >= 4) {
        final a = int.parse(parts[2], radix: 16);
        final b = int.parse(parts[3], radix: 16);
        return ((a * 256) + b) / 4;
      }
    } catch (e) {
      print('Error parsing RPM: $e');
    }
    return null;
  }

  static double? _parseTemperature(String response) {
    try {
      // Response format: 41 05 XX (where temp = XX - 40)
      final parts = response.split(' ');
      if (parts.length >= 3) {
        final tempHex = parts[2];
        return int.parse(tempHex, radix: 16) - 40.0;
      }
    } catch (e) {
      print('Error parsing temperature: $e');
    }
    return null;
  }

  static double? _parseFuelLevel(String response) {
    try {
      // Response format: 41 2F XX (where fuel level = XX * 100 / 255)
      final parts = response.split(' ');
      if (parts.length >= 3) {
        final levelHex = parts[2];
        return (int.parse(levelHex, radix: 16) * 100) / 255;
      }
    } catch (e) {
      print('Error parsing fuel level: $e');
    }
    return null;
  }

  static double? _parseThrottlePosition(String response) {
    try {
      // Response format: 41 11 XX (where throttle = XX * 100 / 255)
      final parts = response.split(' ');
      if (parts.length >= 3) {
        final throttleHex = parts[2];
        return (int.parse(throttleHex, radix: 16) * 100) / 255;
      }
    } catch (e) {
      print('Error parsing throttle position: $e');
    }
    return null;
  }

  static double? _parseBatteryVoltage(String response) {
    try {
      // Response format: 41 42 XX YY (where voltage = ((XX * 256) + YY) / 1000)
      final parts = response.split(' ');
      if (parts.length >= 4) {
        final a = int.parse(parts[2], radix: 16);
        final b = int.parse(parts[3], radix: 16);
        return ((a * 256) + b) / 1000;
      }
    } catch (e) {
      print('Error parsing battery voltage: $e');
    }
    return null;
  }
}
