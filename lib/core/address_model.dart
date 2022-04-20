import 'dart:convert';

import 'package:hive/hive.dart';
part 'address_model.g.dart';

Address cepModelFromJson(String str) => Address.fromJson(json.decode(str));

String cepModelToJson(Address data) => json.encode(data.toJson());

@HiveType(typeId: 1)
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
  @HiveField(0)
  String cep;
  @HiveField(1)
  String logradouro;
  @HiveField(2)
  String complemento;
  @HiveField(3)
  String bairro;
  @HiveField(4)
  String localidade;
  @HiveField(5)
  String uf;
  @HiveField(6)
  String ibge;
  @HiveField(7)
  String gia;
  @HiveField(8)
  String ddd;
  @HiveField(9)
  String siafi;
  @HiveField(10)
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
