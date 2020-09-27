class CalculadoraCombustivel{

  double precoAlcool;
  double precoGasolina;

  static final  precoMAximo = 0.7;

  CalculadoraCombustivel(double precoAlcool, double  precoGasolina){
    this.precoAlcool=precoAlcool;
    this.precoGasolina=precoGasolina;
  }

  double calcular(){
    var calculo = precoAlcool/precoGasolina;
    var valorArredondado = num.parse(calculo.toStringAsFixed(2)).toDouble();
    return valorArredondado;
  }

  bool alcoolEMaisVantajoso(){
    return calcular() <= precoMAximo;
  }


}