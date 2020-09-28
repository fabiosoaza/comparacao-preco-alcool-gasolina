import 'package:calculadora_alcool_gasolina/calculadora_combustivel.dart';
import 'package:calculadora_alcool_gasolina/validador_preco.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Álcool X Gasolina',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(title: 'Calculadora Álcool X Gasolina'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _precoGasolinaController  = TextEditingController();
  TextEditingController _precoAlcoolController = TextEditingController();
  String _resultado;
  GlobalKey<FormState> _formularioKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    resetFields();
  }

  void resetFields() {
    var valorDefault = '0.0';
    _precoGasolinaController.text = valorDefault;
    _precoAlcoolController.text = valorDefault;
    setState(() {
      _resultado = 'Informe o preço do Álcool e da Gasolina para comparação.';
    });
  }

  void compararPrecos(){
    setState(() {
      var calculadora = CalculadoraCombustivel(precoConvertido(_precoAlcoolController.text), precoConvertido(_precoGasolinaController.text) );
      var porcentagemFormatada = formatarPorcentagem(calculadora.calcular());
      var combustivelMaisVantajoso = calculadora.alcoolEMaisVantajoso() ? "Álcool" : "Gasolina";
      _resultado = "Melhor abastecer com ${combustivelMaisVantajoso} pois o preço do álcool está custando ${porcentagemFormatada}% do valor da gasolina.";
    });
  }

  String formatarPorcentagem(double calculo) {
   var porcentagem = calculo * 100;
   RegExp regex = RegExp(r"([.]*0)(?!.*\d)");
   return num.parse(porcentagem.toStringAsFixed(2)).toDouble().toString().replaceAll(regex, "");
  }

  double precoConvertido(String preco){
    return double.parse(preco);
  }

  Widget buildCompararPrecoButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 26.0),
      child: RaisedButton(
        onPressed: () {
          if (_formularioKey.currentState.validate()) {
            compararPrecos();
          }
        },
        child: Text("Comparar", style: TextStyle(
            color: Colors.white,
          fontSize: 32,
        )
        ),
        color: Colors.deepPurple,
      ),
    );
  }

  Widget buildTextResultado() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _resultado,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          color: Colors.black87,
        ),
      ),

    );
  }

  Form buildForm() {
    return Form(
      key: _formularioKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
              label: "Preço Gasolina(R\$)",
              error: "Informe um preço válido(R\$)",
              controller: _precoGasolinaController),
          buildTextFormField(
              label: "Preço Álcool(R\$)",
              error: "Informe um preço válido(R\$)",
              controller: _precoAlcoolController),
          buildTextResultado(),
          buildCompararPrecoButton(),
        ],
      ),
    );
  }

  TextFormField buildTextFormField(
      {TextEditingController controller, String error, String label}) {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
      ],
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, errorStyle:  TextStyle(fontSize: 19)),
      controller: controller,
      validator: (text) {
        return ValidadorPreco(text).validar()? null : error;
      },
      style: TextStyle(
        fontSize: 32,
        color: Colors.black87,
      ),
    );
  }



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), child: buildForm()));
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Comparar Preço Álcool/Gasolina"),
      backgroundColor: Colors.deepPurple,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            resetFields(); //resetFields;
          },
        )
      ],
    );
  }


}
