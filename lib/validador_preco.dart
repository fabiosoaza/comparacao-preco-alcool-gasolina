class ValidadorPreco {
  String preco;

  ValidadorPreco(String preco) {
    this.preco = preco;
  }

  bool validar() {
    return preco != null &&
        preco.isNotEmpty &&
        double.tryParse(preco) != null &&
        double.tryParse(preco) > 0
    ;
  }
}
