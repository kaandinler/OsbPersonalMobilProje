import 'dart:convert';

List<MeterModal> userFromJson(String str) =>
    List<MeterModal>.from(json.decode(str).map((x) => MeterModal.fromJson(x)));
String userToJson(List<MeterModal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MeterModal {
  String Oid;
  String MeterModalName;

//Constructor method.
  MeterModal({
    required this.Oid,
    required this.MeterModalName,
  });

  factory MeterModal.fromJson(Map<String, dynamic> json) => MeterModal(
        Oid: json["meterModelOid"],
        MeterModalName: json["meterModelName"],
      );
  Map<String, dynamic> toJson() => {"Oid": Oid, "meterModelName": MeterModal};
}
