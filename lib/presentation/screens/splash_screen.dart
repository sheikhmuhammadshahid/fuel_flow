import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_gas_station,
                size: 60,
                color: AppColors.primary,
              ),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

            const SizedBox(height: 32),

            // App Name
            Text(
                  'Fuel Flow',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                )
                .animate()
                .fadeIn(duration: 800.ms, delay: 200.ms)
                .slideY(begin: 0.3, end: 0, duration: 800.ms, delay: 200.ms),

            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Vehicle Monitoring & Fuel Tracking',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.white.withValues(alpha: 0.8),
              ),
            ).animate().fadeIn(duration: 800.ms, delay: 400.ms),

            const SizedBox(height: 64),

            // Loading indicator
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.white.withValues(alpha: 0.8),
                ),
                strokeWidth: 3,
              ),
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
