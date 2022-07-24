import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

List<FirmDetail> userFromJson(String str) =>
    List<FirmDetail>.from(json.decode(str).map((x) => FirmDetail.fromJson(x)));
String userToJson(List<FirmDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class FirmDetail {
  FirmDetail({
    required this.Oid,
    required this.firmName,
    required this.firmAddress,
    required this.deviceSerial,
    required this.meter,
    required this.meterModal,
    required this.pulseCounter,
    required this.meterIsSuitable,
    required this.deviceIsPluggedIn,
    required this.isDeviceActive,
    required this.latitude,
    required this.longitude,
  });
  String? Oid;
  String firmName;
  String? firmAddress;
  String? deviceSerial;
  String? meter;
  String? meterModal;
  bool pulseCounter;
  bool meterIsSuitable;
  bool deviceIsPluggedIn;
  bool isDeviceActive;
  dynamic longitude;
  dynamic latitude;

  factory FirmDetail.fromJson(Map<String, dynamic> json) => FirmDetail(
        Oid: json["Oid"],
        firmName: json["firmName"],
        firmAddress: json["address"],
        deviceSerial: json["seri"],
        meter: json["sayacMarka"],
        meterModal: json["sayacMarkaModel"],
        pulseCounter: json["manyetikswitch"],
        meterIsSuitable: json["sayacuygun"],
        deviceIsPluggedIn: json["cihazTakildi"],
        isDeviceActive: json["caktif"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );
  Map<String, dynamic> toJson() => {
        "Oid": Oid,
        "firmName": firmName,
        "address": firmAddress,
      };
}
