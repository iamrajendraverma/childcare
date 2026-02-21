import 'models/cry_analysis_model.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final String? errorMessage;
  final String? successMessage;
  final bool isAuthenticated;
  final List<CryAnalysis> cryAnalyses;

  HomeState({
    this.isLoading = false,
    this.error,
    this.errorMessage,
    this.successMessage,
    this.isAuthenticated = false,
    this.cryAnalyses = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
    String? errorMessage,
    String? successMessage,
    bool? isAuthenticated,
    List<CryAnalysis>? cryAnalyses,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
      errorMessage: errorMessage,
      successMessage: successMessage,
      cryAnalyses: cryAnalyses ?? this.cryAnalyses,
    );
  }
}