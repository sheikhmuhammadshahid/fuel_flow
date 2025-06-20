import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/auth_service.dart';
import '../../data/models/user_model.dart';

// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Current user provider
final currentUserProvider = StreamProvider<User?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

// Current user model provider
final currentUserModelProvider = FutureProvider<UserModel?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getCurrentUserModel();
});

// Authentication state provider
final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>((
  ref,
) {
  return AuthStateNotifier(ref.watch(authServiceProvider));
});

// Authentication state
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final bool isAnonymous;
  final User? user;
  final UserModel? userModel;
  final String? error;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.isAnonymous = false,
    this.user,
    this.userModel,
    this.error,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    bool? isAnonymous,
    User? user,
    UserModel? userModel,
    String? error,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      user: user ?? this.user,
      userModel: userModel ?? this.userModel,
      error: error ?? this.error,
    );
  }
}

// Authentication state notifier
class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _authService.authStateChanges.listen((user) async {
      if (user != null) {
        final userModel = await _authService.getCurrentUserModel();
        state = state.copyWith(
          isAuthenticated: true,
          isAnonymous: user.isAnonymous,
          user: user,
          userModel: userModel,
          isLoading: false,
          error: null,
        );
      } else {
        state = state.copyWith(
          isAuthenticated: false,
          isAnonymous: false,
          user: null,
          userModel: null,
          isLoading: false,
          error: null,
        );
      }
    });
  }

  // Sign in anonymously
  Future<void> signInAnonymously() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authService.signInAnonymously();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign in with email
  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authService.signInWithEmail(email, password);
      if (result == null) {
        state = state.copyWith(isLoading: false, error: 'Failed to sign in');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Register with email
  Future<void> registerWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authService.registerWithEmail(email, password);
      if (result == null) {
        state = state.copyWith(isLoading: false, error: 'Failed to register');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authService.signInWithGoogle();
      if (result == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Google sign-in was cancelled',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Sign in with Apple
  Future<void> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authService.signInWithApple();
      if (result == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Apple sign-in was cancelled',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Link anonymous account with Google
  Future<void> linkAnonymousWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final result = await _authService.linkAnonymousWithGoogle();
      if (result == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to link account',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Update subscription
  Future<void> updateSubscription(UserSubscription subscription) async {
    await _authService.updateUserSubscription(subscription);
    final userModel = await _authService.getCurrentUserModel();
    state = state.copyWith(userModel: userModel);
  }

  // Sign out
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authService.signOut();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Device connection permission provider
final canConnectToDeviceProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.canConnectToDevice();
});

// Subscription status provider
final subscriptionStatusProvider = FutureProvider<String>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.getSubscriptionStatus();
});
