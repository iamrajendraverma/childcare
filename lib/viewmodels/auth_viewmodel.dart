import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/storage_service.dart';
import '../../data/models/login_model.dart';
import '../../data/models/signup_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../data/auth_state.dart';


// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Storage Service Provider
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Auth ViewModel Provider
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final storageService = ref.watch(storageServiceProvider);
  return AuthViewModel(authRepository, storageService);
});


// Auth ViewModel
class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final StorageService _storageService;

  AuthViewModel(this._authRepository, this._storageService) : super(AuthState()) {
    _checkAuthStatus();
  }

  // Check if user is already logged in
  void _checkAuthStatus() {
    final isLoggedIn = _storageService.isLoggedIn();
    state = state.copyWith(isAuthenticated: isLoggedIn);
  }

  // Sign In
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);
    // show progress

    final request = LoginRequest(email: email, password: password);
    final response = await _authRepository.signIn(request);

    if (response.success && response.data != null) {
      // Save token and user data
      await _storageService.saveAuthToken(response.data!.token);
      await _storageService.saveUserData(
        userId: response.data!.user.userId,
        email: response.data!.user.email,
        name: response.data!.user.name,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        successMessage: response.message,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: response.message,
      );
    }
  }

  // Sign Up
  Future<void> signUp(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    final request = SignUpRequest(name: name, email: email, password: password);
    final response = await _authRepository.signUp(request);

    if (response.success && response.data != null) {
      // Save token and user data
      await _storageService.saveAuthToken(response.data!.token);
      await _storageService.saveUserData(
        userId: response.data!.user.userId,
        email: response.data!.user.email,
        name: response.data!.user.name,
      );

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        successMessage: response.message,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        errorMessage: response.message,
      );
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _storageService.clearAll();
    state = state.copyWith(isAuthenticated: false);
  }

  // Clear messages
  void clearMessages() {
    state = state.copyWith(errorMessage: null, successMessage: null);
  }
}

