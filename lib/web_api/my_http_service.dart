import 'dart:convert';
import 'package:flutter_application_1/modal/firm_all_information_modal.dart';
import 'package:http/http.dart';

import '../modal/firm_modal.dart';
import '../modal/meter_modal.dart';
import '../modal/metermodal_modal.dart';

class HttpService {
  // final String postsURL = "http://193.109.135.83:15003/Service1.svc";
  final String postsURL = "http://192.168.1.25/SayacTakipService/Service1.svc";

//Firma listesini getirmek için kullanılacak method.
  Future<List<Firm>> getPosts() async {
    // Response res = await get(Uri.parse(postsURL));
    Response res = await post(Uri.parse(postsURL + '/GetFirms'));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["GetFirmsResult"];
      return data.toList().map((x) => Firm.fromJson(x)).toList();
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  Future<List<Firm>> getFirmAndLocation() async {
    Response res = await post(Uri.parse(postsURL + '/getFirmAndLocation'));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["getFirmAndLocationResult"];
      return data.toList().map((x) => Firm.fromJson(x)).toList();
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  //Sayaç marka bilgileri getirme
  Future<List<Meter>> getMeters() async {
    // Response res = await get(Uri.parse(postsURL));
    Response res = await post(Uri.parse(postsURL + "/getMeterList"));

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["getMeterListResult"];
      return data.toList().map((x) => Meter.fromJson(x)).toList();
    } else {
      throw "Unable to retrieve posts.";
    }
  }

//Sayaca ait modelleri listelemek için kullanılır.
  Future<List<MeterModal>> getMeterModal(String Oid) async {
    // Response res = await get(Uri.parse(postsURL));
    Response res = await post(
      Uri.parse(postsURL + "/getModelList"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'markaOid': Oid,
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      List<dynamic> data = body["getModelListResult"];
      return data.toList().map((x) => MeterModal.fromJson(x)).toList();
    } else {
      throw "Unable to retrieve posts.";
    }
  }

//Okutulan QR kodun bilgilerini kontrol etmek için kullanılır.
  Future<bool> isDeviceAddrTrue(String deviceAddr) async {
    Response res = await post(
      Uri.parse(postsURL + "/findMeter"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'deviceAddr': deviceAddr,
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body["findMeterResult"];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

//Seçilen firma ve o firmaya ait cihazı kontrol etmek için kullanılır.
  Future<bool> contolSelectedFirmAndDevice(
      String firmOid, String deviceAddr) async {
    Response res = await post(
      Uri.parse(postsURL + "/controlSelectedFirmDevice"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firm_oid': firmOid,
        'deviceAddr': deviceAddr,
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body["controlSelectedFirmDeviceResult"];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

//Cihaz bilgilerini kaydetmek için kullanılır.
  Future<String> changeDeviceStatus(
      String firmOid,
      String deviceAddr,
      String longitude,
      String latitude,
      String sayacMarka,
      String sayacModel,
      bool manyetikSwitch,
      bool sayacuygun,
      bool sayactakildi) async {
    Response res = await post(
      Uri.parse(postsURL + "/changeMeterStatus"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firm_oid': firmOid,
        'deviceAddr': deviceAddr,
        'longitude': longitude,
        'latitude': latitude,
        'sayacMarka': sayacMarka,
        'sayacModel': sayacModel,
        'manyetikswitch': manyetikSwitch,
        'sayacuygun': sayacuygun,
        'sayactakildi': sayactakildi,
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return body["changeMeterStatusResult"];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  //Seçilen firma ve o firmaya ait bilgileri getirir.
  Future<FirmDetail> getFirmDetail(String firmName) async {
    Response res = await post(
      Uri.parse(postsURL + "/getFirmDetails"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firmName': firmName,
      }),
    );

    if (res.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(res.body);
      return FirmDetail.fromJson(body["getFirmDetailsResult"]);
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
