import 'dart:math';
import 'package:auto_control_panel/models/location.dart';
import 'package:auto_control_panel/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  test('Deve retornar uma instancia de Location', () async {
    const double latitude = -23.515168106149527;
    const double longitude = -46.1799262754625;
    final resultadoEsperado = isA<Location>();

    final resultado = await LocationService.getLocation(latitude, longitude);

    // Verifica se o resultado é uma instância de Location (Model)
    expect(resultado, resultadoEsperado);
  });
}
