class SignUpState {
  String fullname = '';
  String email = '';
  String password = '';
  bool isLoading = false;
  bool isPasswordVisible = false;
  String? errorMessage;

  bool get isValid => email.contains('@') && password.length >= 6;
}