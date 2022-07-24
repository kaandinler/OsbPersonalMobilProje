import 'package:flutter/material.dart';
import 'package:flutter_application_1/DeviceInfo.dart';
import 'package:flutter_application_1/firma_cihaz_listesi.dart';
import 'package:flutter_application_1/index_bilgisi_gir.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/cihaz_konumlari.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(title: const Text('Barcode scan')),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        // onPressed: () => scanBarcodeNormal(),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeviceInfoRegisteration(),
                            )),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 55, 175, 95),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          minimumSize: Size(110, 110),
                          maximumSize: Size(125, 125),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.qr_code_2_sharp,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'CİHAZ BİLGİSİ\nKAYDET',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CihazHaritasi(),
                            )),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 241, 130, 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          minimumSize: Size(110, 110),
                          maximumSize: Size(125, 125),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.map_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text(
                              'CİHAZ HARİYASI',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  horizontalSpaceMedium,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FirmaCihazListesi(),
                              )),
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          minimumSize: Size(125, 125),
                          maximumSize: Size(125, 125),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.home_work_outlined,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text("FİRMA-CİHAZ LİSTESİ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                      verticalSpaceRegular,
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => IndexBilgisiGir())))
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          minimumSize: Size(125, 125),
                          maximumSize: Size(125, 125),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.gas_meter,
                              color: Colors.white,
                              size: 50,
                            ),
                            Text("INDEX BILGISI GIR",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// -----------------------------------------------------------------------------------------------------------
