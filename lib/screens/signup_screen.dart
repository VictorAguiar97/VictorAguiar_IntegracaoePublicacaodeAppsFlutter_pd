import 'dart:io';

import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  String? imagePath;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    imagePath ?? "Nenhuma Imagem",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16.0),
                  if (imagePath != null)
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Center(
                          child: Image.file(
                            File(imagePath!),
                            width: 200,
                            height: 200,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                imagePath = null;
                              });
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ],
                    )
                  else
                    IconButton(
                      onPressed: () async {
                        var result = await Navigator.of(context)
                            .pushNamed(Routes.SIGNUP_PICTURE_FORM);

                        if (result != null) {
                          setState(() {
                            imagePath = result as String;
                          });
                        }
                      },
                      icon: const Icon(Icons.camera_alt),
                      iconSize: 100.0,
                    ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Informe o email',
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@')) {
                        return 'Informe um email válido';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.key),
                      hintText: 'Informe uma senha',
                      labelText: 'Senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Informe uma senha válida';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate() &&
                          imagePath != null) {
                        try {
                          var storage = FirebaseStorage.instance;
                          var reference = storage.ref().child("userAvatar.jpg");
                          var imageFile = File(imagePath!);

                          reference.putFile(imageFile);
                          // Download da imagem
                          // reference.getData(imageFile);
                        } on FirebaseException catch (e) {
                          print("Erro FirebaseStorage: ${e.message}");
                        }

                        String email = emailController.text;
                        String password = passwordController.text;
                        authProvider.signUp(email, password).then((sucesso) {
                          if (sucesso) {
                            Navigator.pushReplacementNamed(
                                context, Routes.HOME);
                          } else {
                            if (authProvider.message != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authProvider.message!)),
                              );
                            }
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Adicione a foto para Cadastrar!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("Cadastrar"),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.SIGNIN);
                    },
                    child: const Text("Já tenho cadastro"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
