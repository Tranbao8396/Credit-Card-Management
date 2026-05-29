import 'package:credit_management/src/pages/loginPage/widgets/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Title(
          color: Colors.black,
          child: Text(
            'Credit Management System',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        LoginForm(),
        const SizedBox(height: 5),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: const Text('Don\'t have an account? Sign Up'),
        ),
      ],
    );
  }
}
