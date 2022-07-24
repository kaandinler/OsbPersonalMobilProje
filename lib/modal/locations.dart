import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'locations.g.dart';

@JsonSerializable()
class Firm {
  Firm({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.firmName,
    required this.sayacuygun,
    required this.manyetikswitch,
    required this.aktif,
    required this.seri,
  });

  // factory Firm.fromJson(Map<String, dynamic> json) => _$FirmFromJson(json);
  factory Firm.fromJson(Map<String, dynamic> json) => Firm(
        firmName: json["firmName"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        sayacuygun: json["sayacuygun"],
        manyetikswitch: json["manyetikswitch"],
        aktif: json["caktif"],
        seri: json["seri"],
      );
  Map<String, dynamic> toJson() => _$FirmToJson(this);

  final String? address;
  final dynamic latitude;
  final dynamic longitude;
  final String firmName;
  final bool sayacuygun;
  final bool manyetikswitch;
  final String? seri;
  final bool aktif;
}

@JsonSerializable()
class Locations {
  Locations({
    required this.getFirmAndLocationResult,
  });

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);

  final List<Firm> getFirmAndLocationResult;
}

Future<Locations> getFirmsLocation() async {
  const firmLocationURL =
      'http://192.168.1.25/SayacTakipService/Service1.svc/getFirmAndLocation';

  // Retrieve the locations of Google offices
  try {
    final response = await http.post(Uri.parse(firmLocationURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  // Fallback for when the above HTTP request fails.
  return Locations.fromJson(
    json.decode(
      await rootBundle.loadString('assets/locations.json'),
    ) as Map<String, dynamic>,
  );
}
