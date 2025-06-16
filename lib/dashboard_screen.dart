// // Dashboard Screen
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_gauges/gauges.dart';

// import 'history_screen.dart';
// import 'services/fuel_service.dart';

// class DashboardScreen extends StatefulWidget {
//   final bool isObd;
//   final String vehicleName;
//   const DashboardScreen({
//     super.key,
//     required this.isObd,
//     required this.vehicleName,
//   });

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen> {
//   final FuelService _fuelService = FuelService();
//   double fuelLevel = 0.0;
//   double range = 0.0;
//   bool lowFuelAlert = true;

//   @override
//   void initState() {
//     super.initState();
//     _startFuelMonitoring();
//   }

//   void _startFuelMonitoring() {
//     if (widget.isObd) {
//       _fuelService.startObdPolling(); // Mocked for demo
//     } else {
//       _fuelService.startSensorStream(); // Mocked for demo
//     }
//     _fuelService.fuelLevelStream.listen((fuel) {
//       setState(() {
//         fuelLevel = fuel;
//         range = fuel * 5; // Mock range: 5 km per % (adjust with real data)
//         if (fuelLevel < 10 && lowFuelAlert) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text("Low Fuel Warning!")));
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("${widget.vehicleName} Dashboard")),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Fuel Gauge
//             SizedBox(
//               height: 250,
//               child: SfRadialGauge(
//                 axes: [
//                   RadialAxis(
//                     minimum: 0,
//                     maximum: 100,
//                     ranges: [
//                       GaugeRange(
//                         startValue: 0,
//                         endValue: 10,
//                         color: Colors.red,
//                       ),
//                       GaugeRange(
//                         startValue: 10,
//                         endValue: 100,
//                         color: Color(0xFF1E88E5),
//                       ),
//                     ],
//                     pointers: [
//                       RangePointer(
//                         value: fuelLevel,
//                         gradient: SweepGradient(
//                           colors: [Color(0xFF1E88E5), Color(0xFFFF5722)],
//                         ),
//                       ),
//                     ],
//                     annotations: [
//                       GaugeAnnotation(
//                         widget: Text(
//                           "${fuelLevel.toStringAsFixed(1)}%",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             // Stats Cards
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _statCard(
//                   "Range",
//                   "~${range.toStringAsFixed(0)} km",
//                   Icons.directions_car,
//                 ),
//                 _statCard("Fuel Today", "2.3L", Icons.local_gas_station),
//               ],
//             ),
//             SizedBox(height: 20),
//             // Features
//             _featureTile(
//               "Fuel History",
//               Icons.show_chart,
//               () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HistoryScreen()),
//               ),
//             ),
//             SwitchListTile(
//               title: Text("Low Fuel Alert (10%)"),
//               value: lowFuelAlert,
//               onChanged: (val) => setState(() => lowFuelAlert = val),
//               activeColor: Color(0xFFFF5722),
//             ),
//             _featureTile(
//               "Refuel Mode",
//               Icons.local_gas_station,
//               () => setState(() => fuelLevel = 100.0),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _statCard(String title, String value, IconData icon) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           children: [
//             Icon(icon, color: Color(0xFF1E88E5)),
//             SizedBox(height: 8),
//             Text(title, style: TextStyle(fontSize: 16)),
//             Text(
//               value,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _featureTile(String title, IconData icon, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Color(0xFF1E88E5)),
//       title: Text(title),
//       trailing: Icon(Icons.arrow_forward_ios),
//       onTap: onTap,
//     );
//   }
// }
