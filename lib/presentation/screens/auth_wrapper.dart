import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import 'splash_screen.dart';
import 'login_screen.dart';
import 'home_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);

    return currentUserAsync.when(
      data: (user) {
        if (user != null) {
          // User is authenticated, show home screen
          return const HomeScreen();
        } else {
          // User is not authenticated, show login screen
          return const LoginScreen();
        }
      },
      loading: () => const SplashScreen(),
      error: (error, stackTrace) {
        // On error, show login screen
        return const LoginScreen();
      },
    );
  }
}
