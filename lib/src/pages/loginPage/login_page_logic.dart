import 'package:credit_management/src/pages/loginPage/login_state.dart';
import 'package:credit_management/src/services/authentication_service.dart';
import 'package:flutter/material.dart';

class LoginPageLogic extends ChangeNotifier {
  final LoginState state = LoginState();

  void setEmail(String value) {
    state.email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    state.password = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    state.isPasswordVisible = !state.isPasswordVisible;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state.errorMessage = 'Vui lòng nhập email và mật khẩu';
      notifyListeners();
      return;
    }

    state.isLoading = true;
    state.errorMessage = null;
    notifyListeners();

    FocusScope.of(context).unfocus();

    try {
      // Thực hiện logic đăng nhập tại đây
      final authInstance = AuthenticationService.instance;
      await authInstance.signIn(email: state.email, password: state.password);

      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      state.errorMessage = 'Đã xảy ra lỗi khi đăng nhập, xin thử lại sau';
      notifyListeners();
    } finally {
      state.isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    state.email = '';
    state.password = '';
    state.isPasswordVisible = false;
    state.errorMessage = null;
    state.isLoading = false;
    notifyListeners();
  }
}
