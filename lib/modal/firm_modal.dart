import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

List<Firm> userFromJson(String str) =>
    List<Firm>.from(json.decode(str).map((x) => Firm.fromJson(x)));
String userToJson(List<Firm> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class Firm {
  Firm({
    required this.Oid,
    required this.firmName,
    required this.firmAddress,
  });
  String Oid;
  String firmName;
  String? firmAddress;

  factory Firm.fromJson(Map<String, dynamic> json) => Firm(
        Oid: json["Oid"],
        firmName: json["firmName"],
        firmAddress: json["address"],
      );
  Map<String, dynamic> toJson() => {
        "Oid": Oid,
        "firmName": firmName,
        "address": firmAddress,
      };
}
