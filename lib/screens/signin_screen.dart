import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 30.0, // Tamanho da fonte do título
          ),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  key: const Key('textFieldSigninEmail'),
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'email@email.com.br',
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  key: const Key('textFieldSigninSenha'),
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    if (email.isEmpty || password.isEmpty) {
                      return;
                    }

                    await authProvider.signIn(email, password).then((sucesso) {
                      if (sucesso) {
                        Navigator.pushReplacementNamed(context, Routes.HOME);
                      } else {
                        if (authProvider.message != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(authProvider.message!)),
                          );
                        }
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text("Acessar"),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.SIGNUP);
                  },
                  child: const Text("Ainda não tenho cadastro!"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
