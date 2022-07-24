import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/ui/qr_reader_widget.dart';

String selectedFirmdiyelim = '';

class DeviceInfoRegisteration extends StatefulWidget {
  const DeviceInfoRegisteration({Key? key}) : super(key: key);

  @override
  State<DeviceInfoRegisteration> createState() =>
      _DeviceInfoRegisterationState();
}

class _DeviceInfoRegisterationState extends State<DeviceInfoRegisteration> {
  int _selectedIndex = 0;

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
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
              Navigator.pop(context);
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
                children: <Widget>[
                  verticalSpaceLarge,
                  QRScannerWidget(),
                  verticalSpaceMedium,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
