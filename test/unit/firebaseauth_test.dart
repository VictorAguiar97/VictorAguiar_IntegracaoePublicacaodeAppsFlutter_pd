import 'dart:math';

import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('Deve retornar TRUE para o login', () async {
    const email = 'victor@infopack.com.br';
    const password = '123456';
    const resultadoExperado = true;

    final authprovider = AuthProvider();

    final sucesso = await authprovider.signIn(email, password);

    expect(sucesso, resultadoExperado);
  });
}
