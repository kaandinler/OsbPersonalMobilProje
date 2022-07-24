import 'dart:convert';

List<Meter> userFromJson(String str) =>
    List<Meter>.from(json.decode(str).map((x) => Meter.fromJson(x)));
String userToJson(List<Meter> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Meter {
  String Oid;
  String MeterBrand;

//Constructor method.
  Meter({
    required this.Oid,
    required this.MeterBrand,
  });

  factory Meter.fromJson(Map<String, dynamic> json) => Meter(
        Oid: json["meterOid"],
        MeterBrand: json["meterBrand"],
      );
  Map<String, dynamic> toJson() => {"meterOid": Oid, "meterBrand": MeterBrand};
}
