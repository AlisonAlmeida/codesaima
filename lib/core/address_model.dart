import 'dart:convert';

Address cepModelFromJson(String str) => Address.fromJson(json.decode(str));

String cepModelToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    this.cep = '',
    this.logradouro = '',
    this.complemento = '',
    this.bairro = '',
    this.localidade = '',
    this.uf = '',
    this.ibge = '',
    this.gia = '',
    this.ddd = '',
    this.siafi = '',
    this.numero = '',
  });

  String cep;
  String logradouro;
  String complemento;
  String bairro;
  String localidade;
  String uf;
  String ibge;
  String gia;
  String ddd;
  String siafi;
  String numero;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        ibge: json["ibge"],
        gia: json["gia"],
        ddd: json["ddd"],
        siafi: json["siafi"],
      );

  Map<String, dynamic> toJson() => {
        "cep": cep,
        "logradouro": logradouro,
        "complemento": complemento,
        "bairro": bairro,
        "localidade": localidade,
        "uf": uf,
        "ibge": ibge,
        "gia": gia,
        "ddd": ddd,
        "siafi": siafi,
      };

  @override
  String toString() {
    return 'CEP: $cep, Logradouro: $logradouro, Complemento: $complemento, Bairro: $bairro, Localidade: $localidade, UF: $uf, IBGE: $ibge, GIA: $gia, DDD: $ddd, SIAFI: $siafi, Número: $numero';
  }
}
