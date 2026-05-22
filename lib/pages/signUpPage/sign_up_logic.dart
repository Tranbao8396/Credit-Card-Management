import 'package:credit_management/pages/signUpPage/sign_up_state.dart';
import 'package:credit_management/services/authentication_service.dart';
import 'package:credit_management/widgets/notify_dialog.dart';
import 'package:flutter/material.dart';

class SignUpLogic extends ChangeNotifier {
  final SignUpState state = SignUpState();
  void setEmail(String value) {
    state.email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    state.password = value;
    notifyListeners();
  }

  void setFullname(String value) {
    state.fullname = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    state.isPasswordVisible = !state.isPasswordVisible;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    if (!state.isValid) {
      state.errorMessage = 'Hãy nhập mật khẩu hoạc email cho đúng vào';
      notifyListeners();
      return;
    }

    state.isLoading = true;
    state.errorMessage = null;
    notifyListeners();

    FocusScope.of(context).unfocus();

    try {
      final authInstance = AuthenticationService.instance;

      await authInstance.signUp(
        email: state.email,
        password: state.password,
        name: state.fullname,
      );

      if (!context.mounted) return;
      NotifyDialogWidget.show(
        context,
        'Thành công',
        'Đăng ký tài khoản thành công! Chuyển hướng sang trang chủ',
      );
      await Future.delayed(Duration(seconds: 2));
      if (!context.mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } catch (e) {
      state.errorMessage = 'Đã xảy ra lỗi khi đăng ký, xin thử lại sau';
      notifyListeners();
    } finally {
      state.isLoading = false;
      notifyListeners();
    }
  }
}
