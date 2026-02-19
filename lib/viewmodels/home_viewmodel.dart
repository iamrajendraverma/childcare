import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/storage_service.dart';
import '../data/home_state.dart';
import '../data/repositories/home_repository.dart';
import 'auth_viewmodel.dart';

// Home Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) {
    final storageService = ref.read(storageServiceProvider);
    final homeRepository = ref.read(homeRepositoryProvider);
    return HomeViewModel(storageService, homeRepository);
  },
);

class HomeViewModel extends StateNotifier<HomeState> {
  final StorageService _storageService;
  final HomeRepository _homeRepository;

  HomeViewModel(this._storageService, this._homeRepository) : super(HomeState()) {
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    final isLoggedIn = _storageService.isLoggedIn();
    state = state.copyWith(isAuthenticated: isLoggedIn);
  }

  // Upload Recording
  Future<void> uploadRecording(String filePath) async {
    final token = _storageService.getAuthToken();
    
    if (token == null) {
      state = state.copyWith(errorMessage: 'Authentication required');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null, successMessage: null);

    final result = await _homeRepository.uploadRecording(
      filePath: filePath,
      token: token,
    );

    if (result['success'] == true) {
      state = state.copyWith(
        isLoading: false,
        successMessage: result['message'],
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: result['message'],
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