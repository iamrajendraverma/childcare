class HomeState {
  final bool isLoading;
  final String? error;
  final String? errorMessage;
  final String? successMessage;
  final bool isAuthenticated;
  HomeState({
    this.isLoading = false,
    this.error,
    this.errorMessage,
    this.successMessage,
    this.isAuthenticated = false,
  });
HomeState copyWith({
  bool? isLoading,
  String? error,
  String? errorMessage,
  String? successMessage,
  bool? isAuthenticated,
}) {
  return HomeState(
    isLoading: isLoading ?? this.isLoading,
    isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    error: error,
    errorMessage: errorMessage,
    successMessage: successMessage,
  );
}

   }   