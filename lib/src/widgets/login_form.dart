import 'package:credit_management/src/pages/loginPage/login_page_logic.dart';
import 'package:credit_management/src/widgets/card_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginPageLogic(),
      child: Consumer<LoginPageLogic>(
        builder: (context, logic, child) {
          final state = logic.state;
          return Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 4,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 4,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 4),
                      ),
                      errorText: state.errorMessage,
                    ),
                    onChanged: (value) => logic.setEmail(value),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 4,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 4,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: logic.togglePasswordVisibility,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.red, width: 4),
                      ),
                      errorText: state.errorMessage,
                    ),
                    onChanged: (value) => logic.setPassword(value),
                    obscureText: !state.isPasswordVisible,
                  ),
                  const SizedBox(height: 20),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : CardButton(
                          onPressed: () => logic.login(context),
                          buttonColor: const Color.fromARGB(255, 94, 99, 31),
                          text: 'Login',
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
