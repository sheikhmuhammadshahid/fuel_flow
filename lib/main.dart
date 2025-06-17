// import 'package:flutter/material.dart';

// import 'dashboard_screen.dart';

// void main() => runApp(FuelFlowApp());

// class FuelFlowApp extends StatelessWidget {
//   const FuelFlowApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'FuelFlow',
//       theme: ThemeData(
//         primaryColor: Color(0xFF1E88E5),
//         scaffoldBackgroundColor: Color(0xFFF5F6FA),
//         fontFamily: 'Poppins',
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ),
//       home: WelcomeScreen(),
//     );
//   }
// }

// // Welcome Screen
// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF1E88E5), Color(0xFFFF5722)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Welcome to FuelFlow",
//                 style: TextStyle(
//                   fontSize: 32,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 40),
//               ElevatedButton(
//                 onPressed:
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SetupScreen(isObd: true),
//                       ),
//                     ),
//                 child: Text("I have OBD-II", style: TextStyle(fontSize: 18)),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed:
//                     () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => SetupScreen(isObd: false),
//                       ),
//                     ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFFF5722),
//                 ),
//                 child: Text("No OBD-II", style: TextStyle(fontSize: 18)),
//               ),
//               SizedBox(height: 20),
//               TextButton(
//                 onPressed:
//                     () => showDialog(
//                       context: context,
//                       builder:
//                           (_) => AlertDialog(
//                             title: Text(
//                               "OBD-II is found in most cars post-1996.",
//                             ),
//                           ),
//                     ),
//                 child: Text(
//                   "Not sure? Check here",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Setup Screen
// class SetupScreen extends StatefulWidget {
//   final bool isObd;
//   const SetupScreen({super.key, required this.isObd});

//   @override
//   _SetupScreenState createState() => _SetupScreenState();
// }

// class _SetupScreenState extends State<SetupScreen> {
//   String vehicleType = 'Car';
//   String vehicleName = '';
//   bool isConnecting = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Set Up Your Ride")),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             DropdownButton<String>(
//               value: vehicleType,
//               items:
//                   ['Car', 'Bike', 'Truck']
//                       .map((v) => DropdownMenuItem(value: v, child: Text(v)))
//                       .toList(),
//               onChanged: (val) => setState(() => vehicleType = val!),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: "Vehicle Name (e.g., My Honda)",
//               ),
//               onChanged: (val) => vehicleName = val,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed:
//                   vehicleName.isEmpty
//                       ? null
//                       : () {
//                         setState(() => isConnecting = true);
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (_) => DashboardScreen(
//                                   isObd: widget.isObd,
//                                   vehicleName: vehicleName,
//                                 ),
//                           ),
//                         );
//                       },
//               child: Text("Connect Now"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'providers/obd_service_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.location.request();
  await Permission.bluetooth.request();
  await Permission.bluetoothConnect.request();
  await Permission.bluetoothScan.request();
  await Permission.bluetoothAdvertise.request();
  FlutterBluePlus.setLogLevel(LogLevel.debug);

  runApp(
    ChangeNotifierProvider(
      create: (_) => OBDModel(),
      child: const OBDMonitorApp(),
    ),
  );
}

class OBDMonitorApp extends StatelessWidget {
  const OBDMonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OBDModel>().startListening();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OBD-II Monitor'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              !context.watch<OBDModel>().isBluetoothEnabled
                  ? Icons.bluetooth_disabled
                  : Icons.bluetooth,
            ),
            onPressed: () {
              // Navigate to settings screen
              if (!context.read<OBDModel>().isBluetoothEnabled &&
                  Platform.isAndroid) {
                context.read<OBDModel>().changeBluetoothState();
              }
            },
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<OBDModel>(
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Connection Status
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Status: ${model.connectionStatus}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed:
                              model.connectionStatus == "Connected"
                                  ? model.disconnect
                                  : () {
                                    model.scan(context);
                                  },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            model.connectionStatus == "Connected"
                                ? "Disconnect"
                                : "Connect",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Error Message
                if (model.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Error: ${model.errorMessage}",
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),

                // Data Display
                if (model.obdData != null) ...[
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        DataCard(
                          title: "RPM",
                          value: model.obdData!.rpm.toStringAsFixed(0),
                          unit: "rev/min",
                          icon: Icons.speed,
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.lightBlue],
                          ),
                        ),
                        DataCard(
                          title: "Speed",
                          value: model.obdData!.speed.toStringAsFixed(0),
                          unit: "km/h",
                          icon: Icons.directions_car,
                          gradient: const LinearGradient(
                            colors: [Colors.green, Colors.lightGreen],
                          ),
                        ),
                        DataCard(
                          title: "Fuel Level",
                          value: model.obdData!.fuelLevel.toStringAsFixed(1),
                          unit: "%",
                          icon: Icons.local_gas_station,
                          gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.yellow],
                          ),
                        ),
                        DataCard(
                          title: "Coolant Temp",
                          value: model.obdData!.coolantTemp.toStringAsFixed(0),
                          unit: "°C",
                          icon: Icons.thermostat,
                          gradient: const LinearGradient(
                            colors: [Colors.red, Colors.pink],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // DTC Codes
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "DTC Codes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            model.obdData!.dtcCodes.isEmpty
                                ? "No codes found"
                                : model.obdData!.dtcCodes.join(", "),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          if (model.obdData!.dtcCodes.isNotEmpty)
                            ElevatedButton(
                              onPressed: model.clearDtcCodes,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Clear Codes"),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Refresh Button
                if (model.connectionStatus == "Connected")
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: model.refreshData,
                        icon: const Icon(Icons.refresh),
                        label: const Text("Refresh Data"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Custom Data Card Widget
class DataCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Gradient gradient;

  const DataCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.gradient,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              "$value $unit",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
