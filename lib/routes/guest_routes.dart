import 'package:credit_management/pages/loginPage/login_page.dart';
import 'package:credit_management/pages/signUpPage/sign_up_page.dart';

class GuestRoutes {
  static Map<String, dynamic> getRoutes() {
    return {
      '/login': {'title': '', 'widget': const LoginPage()},
      '/signup': {'title': 'Sign Up', 'widget': const SignUpPage()},
    };
  }
}
