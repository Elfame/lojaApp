// teste dados para API dos correios

class CorreiosSize {



  CorreiosSize.fromMap(Map<String,dynamic> map){
    altura = map['altura'] as num;
    comprimento = map['comprimento'] as num;
    largura = map['largura'] as num;
    peso = map['peso'] as num;





  }




num altura;
num comprimento;
num largura;
num peso;

  @override
  String toString() {
    return 'CorreiosSize{altura: $altura, comprimento: $comprimento, largura: $largura, peso: $peso}';
  }
}