import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../modal/meter_modal.dart';
import '../modal/metermodal_modal.dart';
import '../shared/ui_helpers.dart';
import '../web_api/my_http_service.dart';

class FirmAndMeters extends StatefulWidget {
  final Function onMeterChanged;
  final Function onMeterModalChanged;

  FirmAndMeters(
      {Key? key,
      required this.onMeterChanged,
      required this.onMeterModalChanged})
      : super(key: key);

  @override
  // State<FirmAndMeters> createState() => _FirmAndMetersState();
  _FirmAndMetersState createState() => _FirmAndMetersState();

  static String eslestirmeSonucu = "Sayaç Modeli Seçiniz...";
}

class _FirmAndMetersState extends State<FirmAndMeters> {
  String dropdownMeterValue = "Sayaç Markası Seçiniz...";
  String selectedFirmOid = 'Unknown';
  // String dropdownMeterModalValue = "Sayaç Modeli Seçiniz...";
  String dropdownMeterModalValue = FirmAndMeters.eslestirmeSonucu;

  bool eslestirmeSonucu() {
    bool sonuc = false;
    if (dropdownMeterModalValue != 'Model Seçiniz...' ||
        dropdownMeterModalValue != 'Sayaç Modeli Seçiniz...' ||
        dropdownMeterModalValue.contains('Sayaç')) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: Text(dropdownMeterModalValue),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    return sonuc;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.4,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: _getMeterName(context),
                  )),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.1),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.4,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color.fromRGBO(
                                0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: _getMeterModal(context),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  FutureBuilder<List<Meter>> _getMeterName(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<Meter>>(
        future: httpService.getMeters(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Meter>? posts = snapshot.data;
            return Container(
              child: DropdownButton<String>(
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                icon: Icon(Icons.arrow_circle_down_rounded),
                iconEnabledColor: Color.fromRGBO(10, 161, 221, 1),
                alignment: Alignment.centerLeft,
                dropdownColor: Colors.blueAccent,
                underline: Container(),
                iconSize: 24,
                isExpanded: true,
                elevation: 16,
                hint: Text(dropdownMeterValue),
                items: snapshot.data?.map<DropdownMenuItem<String>>(
                  (item) {
                    return DropdownMenuItem<String>(
                      value: item.Oid,
                      child: Text(item.MeterBrand),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedFirmOid = newValue!;
                    dropdownMeterValue = newValue;
                    dropdownMeterValue = posts!
                        .firstWhere(
                            (element) => element.Oid == dropdownMeterValue)
                        .MeterBrand;
                    dropdownMeterModalValue = 'Model Seçiniz...';
                    widget.onMeterChanged(dropdownMeterValue);
                  });
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  FutureBuilder<List<MeterModal>> _getMeterModal(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<MeterModal>>(
        future: httpService.getMeterModal(selectedFirmOid),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<MeterModal>? posts = snapshot.data;
            return Container(
              child: DropdownButton<String>(
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                icon: Icon(Icons.arrow_circle_down_rounded),
                iconEnabledColor: Color.fromRGBO(10, 161, 221, 1),
                alignment: Alignment.centerLeft,
                dropdownColor: Colors.blueAccent,
                underline: Container(),
                iconSize: 24,
                isExpanded: true,
                elevation: 16,
                hint: Text(dropdownMeterModalValue),
                items: snapshot.data?.map<DropdownMenuItem<String>>(
                  (item) {
                    return DropdownMenuItem<String>(
                      value: item.Oid,
                      child: Text(item.MeterModalName),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownMeterModalValue = newValue!;
                    dropdownMeterModalValue = posts!
                        .firstWhere(
                            (element) => element.Oid == dropdownMeterModalValue)
                        .MeterModalName;
                    widget.onMeterModalChanged(dropdownMeterModalValue);
                  });
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}
