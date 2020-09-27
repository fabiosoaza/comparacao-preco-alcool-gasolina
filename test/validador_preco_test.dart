
import 'package:calculadora_alcool_gasolina/validador_preco.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Deve retornar false caso o preço seja nulo.', () {
    String preco = null;
    var validador = ValidadorPreco(preco);
    expect(validador.validar(), false);

  });
  test('Deve retornar false caso o preço seja vazio.', () {
    String preco = '';
    var validador = ValidadorPreco(preco);
    expect(validador.validar(), false);
  });
  test('Deve retornar false caso o preço não seja numérico.', () {
    String preco = 'quatro reais e sessenta centavos';
    var validador = ValidadorPreco(preco);
    expect(validador.validar(), false);

  });
  test('Deve retornar true caso o preço seja numérico.', () {
    String preco = '4.37';
    var validador = ValidadorPreco(preco);
    expect(validador.validar(), true);

  });
}