import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app_theme.dart';
import 'core/dependency_injection.dart';
import 'firebase_options.dart';
import 'presentation/screens/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize dependencies
  await DependencyInjection.initialize();

  // Request permissions on app startup
  await _requestInitialPermissions();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ProviderScope(child: FuelFlowApp()));
}

/// Request essential permissions on app startup
Future<void> _requestInitialPermissions() async {
  try {
    final permissionService = DependencyInjection.permissionService;
    await permissionService.requestAllPermissions();
  } catch (e) {
    // Handle permission request errors gracefully
    debugPrint('Error requesting initial permissions: $e');
  }
}

class FuelFlowApp extends StatelessWidget {
  const FuelFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Flow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthWrapper(),
    );
  }
}
