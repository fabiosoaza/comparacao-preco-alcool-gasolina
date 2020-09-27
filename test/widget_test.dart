
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:calculadora_alcool_gasolina/main.dart';

void main() {
  testWidgets('Preço da gasolina deve ser mais vantajoso', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(find.text('Preço Gasolina(R\$)'), findsOneWidget);
    expect(find.text('Preço Álcool(R\$)'), findsOneWidget);
    expect(find.text('Informe o preço do Álcool e da Gasolina para comparação.'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Preço Gasolina(R\$)'), '4.37');
    await tester.enterText(find.widgetWithText(TextField, 'Preço Álcool(R\$)'), '3.69');


    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    var combustivelMaisVantajoso = "Gasolina";
    var porcentagemFormatada = "0.84";

    var mensagemEsperada = "Melhor abastecer com ${combustivelMaisVantajoso} pois o preço do álcool está custando ${porcentagemFormatada}% do valor da gasolina.";


    expect(find.text(mensagemEsperada), findsOneWidget);
  });
}
