// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Firm _$FirmFromJson(Map<String, dynamic> json) => Firm(
      address: json['address'] as String?,
      latitude: json['latitude'],
      longitude: json['longitude'],
      firmName: json['firmName'] as String,
      sayacuygun: json['sayacuygun'] as bool,
      manyetikswitch: json['manyetikswitch'] as bool,
      aktif: json['aktif'] as bool,
      seri: json['seri'] as String,
    );

Map<String, dynamic> _$FirmToJson(Firm instance) => <String, dynamic>{
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'firmName': instance.firmName,
      'sayacuygun': instance.sayacuygun,
      'manyetikswitch': instance.manyetikswitch,
      'seri': instance.seri,
      'aktif': instance.aktif,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      getFirmAndLocationResult:
          (json['getFirmAndLocationResult'] as List<dynamic>)
              .map((e) => Firm.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'getFirmAndLocationResult': instance.getFirmAndLocationResult,
    };
