import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/ui/checkboxes_widget.dart';
import 'package:flutter_application_1/ui/firms_widget.dart';
import 'package:flutter_application_1/ui/meters_widget.dart';
import 'package:flutter_application_1/web_api/my_http_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AfterQRScan extends StatefulWidget {
  final String qrCode;
  const AfterQRScan({Key? key, required this.qrCode}) : super(key: key);

  @override
  State<AfterQRScan> createState() => _AfterQRScanState();
}

class _AfterQRScanState extends State<AfterQRScan> {
  String selectedFirmOid = 'Unknown';

  String sayacMarka = "";
  String sayacModel = "";

  bool sonuc = false;
  bool cihazTakildi = false;
  bool manyetikSwitchVar = false;
  bool sayacUygunDegil = false;

  //Getting Position
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.best, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude);
      print(position.latitude);

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        long = position.longitude.toString();
        lat = position.latitude.toString();
      });
    });
  }

  Future<void> _cihazBilgileriniKaydet() async {
    final HttpService httpService = HttpService();
    _isDeviceAddrTrue().then((value) => {
          if (value)
            {
              FutureBuilder<String>(
                  future: httpService.changeDeviceStatus(
                      selectedFirmOid,
                      widget.qrCode,
                      long,
                      lat,
                      sayacMarka,
                      sayacModel,
                      manyetikSwitchVar,
                      sayacUygunDegil,
                      cihazTakildi),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == "Cihaz Takıldı") {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text('${snapshot.data}');
                      }
                    } else {
                      return const Center(
                        child: Text('Hata...Tekrar Deneyin.'),
                      );
                    }
                  })),
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bilgi'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Cihaz bilgileri kaydedildi.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )
            }
          else
            {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Hata'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Firma ve cihaz eşleştirmesi HATALI.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tamam'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              )
            }
        });
  }

  Future<bool> _isDeviceAddrTrue() async {
    final HttpService httpService = HttpService();
    return await httpService.contolSelectedFirmAndDevice(
        selectedFirmOid, widget.qrCode);
  }

//Get location when the program is initialized
  @override
  void initState() {
    _determinePosition();
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Midsoft Cihaz Bilgisi Kayıt',
            style: TextStyle(color: Colors.black38),
          ),
          backgroundColor: Colors.blue[50],
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
          iconTheme: IconThemeData(
            color: Colors.black38, //change your color here
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(121, 218, 232, 1)),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FirmsWidget(onFirmSelected: (selectedFirmOid) {
                    this.selectedFirmOid = selectedFirmOid;
                  }),
                  verticalSpaceTiny,
                  FirmAndMeters(onMeterChanged: (selectedMeter) {
                    sayacMarka = selectedMeter;
                  }, onMeterModalChanged: (selectedMeterModal) {
                    sayacModel = selectedMeterModal;
                  }),
                  verticalSpaceTiny,
                  CheckBoxesWidget(
                    onCihazTakildiChanged: (cihazTakildi) {
                      this.cihazTakildi = cihazTakildi;
                    },
                    onManyetikSwitchChanged: (manyetikSwitchVar) {
                      this.manyetikSwitchVar = manyetikSwitchVar;
                    },
                    onSayacUygunDegilChanged: (sayacUygunDegil) {
                      this.sayacUygunDegil = sayacUygunDegil;
                    },
                  ),
                  verticalSpaceLarge,
                  FloatingActionButton.extended(
                    onPressed: () => _cihazBilgileriniKaydet(),
                    label: Text(
                      'Kaydet',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    icon: Icon(Icons.save),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
