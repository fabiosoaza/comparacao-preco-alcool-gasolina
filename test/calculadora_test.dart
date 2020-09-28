import 'package:calculadora_alcool_gasolina/calculadora_combustivel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve calcular a diferença do preço do álcool pela gasolina', () {
    var precoGasolina = 4.37;
    var precoAlcool = 3.69;
    var calculadora = CalculadoraCombustivel(precoAlcool, precoGasolina);
    var valor = calculadora.calcular();
    var valorEsperado = 0.8444;

    expect(valor, valorEsperado);
  });

  test('Deve retornar o preço da gasolina como mais vantajoso', () {
    var precoGasolina = 4.37;
    var precoAlcool = 3.69;
    var calculadora = CalculadoraCombustivel(precoAlcool, precoGasolina);
    expect(calculadora.alcoolEMaisVantajoso(), false);
  });

  test('Deve retornar o preço do álcool como mais vantajoso', () {
    var precoGasolina = 4.37;
    var precoAlcool = 1.69;
    var calculadora = CalculadoraCombustivel(precoAlcool, precoGasolina);
    expect(calculadora.alcoolEMaisVantajoso(), true);
  });
}