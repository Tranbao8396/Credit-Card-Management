import 'package:credit_management/src/pages/signUpPage/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Title(
          color: Colors.black,
          child: Text('Đăng ký ở đây'),
        ),
        SignUpForm(),
        const SizedBox(height: 5),
      ],
    );
  }
}
