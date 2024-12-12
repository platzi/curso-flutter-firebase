class AuthState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isAuthenticated;

  AuthState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    this.errorMessage,
    required this.isAuthenticated,
  });

  factory AuthState.initial() {
    return AuthState(
      email: '',
      password: '',
      isSubmitting: false,
      errorMessage: null,
      isAuthenticated: false,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? errorMessage,
    bool? isAuthenticated,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
