import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/ui/after_qr_scan.dart';
import 'package:flutter_application_1/web_api/my_http_service.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRScannerWidget extends StatefulWidget {
  const QRScannerWidget({Key? key}) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  String _scanBarcode = 'Unknown';
  bool isVisible = false;

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'İptal', true, ScanMode.QR);

      if (barcodeScanRes == '-1') return;

      if (barcodeScanRes.contains("DevAddr")) {
        final splitted = barcodeScanRes.split(' ');
        for (int i = 0; i < splitted.length; i++) {
          if (splitted[i].contains("DevAddr")) {
            barcodeScanRes = splitted[i + 1];
          }
        }
      }

      // print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    HttpService httpService = HttpService();
    bool isDeviceAddrTrue = await httpService.isDeviceAddrTrue(barcodeScanRes);

    if (isDeviceAddrTrue) {
      setState(() {
        isVisible = true;
      });
    } else {
      setState(() {
        isVisible = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hata"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Text("Cihaz adresi doğru değil."),
            actions: <Widget>[
              TextButton(
                child: Text("Tamam Abi Özür Dilerim"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Row(
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[200],
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.57),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        1.0,
                      ),
                    ),
                  ],
                ),
                child: Text(
                  'Cihaz Adresi: $_scanBarcode',
                  overflow: TextOverflow.clip,
                  maxLines: 24,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              verticalSpaceSmall,
              Container(
                child: FloatingActionButton.extended(
                  heroTag: null,
                  backgroundColor: Colors.blue,
                  onPressed: () => {scanQR()},
                  icon: Icon(Icons.camera),
                  splashColor: Colors.blueGrey[50],
                  label: Text('Kamera'),
                ),
              ),
              verticalSpaceLarge,
              Container(
                child: Visibility(
                  visible: isVisible,
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AfterQRScan(qrCode: _scanBarcode)));
                    },
                    label: Text('Sonraki Adıma Geç',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    icon: Icon(Icons.check),
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  }
}
