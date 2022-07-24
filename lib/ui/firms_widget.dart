import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';

import '../modal/firm_modal.dart';
import '../web_api/my_http_service.dart';

class FirmsWidget extends StatefulWidget {
  final Function onFirmSelected;
  const FirmsWidget({Key? key, required this.onFirmSelected}) : super(key: key);

  @override
  State<FirmsWidget> createState() => _FirmsWidgetState();
}

class _FirmsWidgetState extends State<FirmsWidget> {
  String dropdownValue = "Firma Seçiniz...";
  String selected = "";

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceRegular,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
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
                      child: _kaanFirms(context),
                    )),
              ),
            ],
          )
        ]);
  }

  FutureBuilder<List<Firm>> _kaanFirms(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<Firm>>(
        future: httpService.getPosts(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List<Firm>? posts = snapshot.data;
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
                hint: Text(dropdownValue),
                items: snapshot.data?.map<DropdownMenuItem<String>>(
                  (item) {
                    return DropdownMenuItem<String>(
                      value: item.Oid,
                      child: Text(item.firmName),
                    );
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    dropdownValue = posts!
                        .firstWhere((element) => element.Oid == dropdownValue)
                        .firmName;
                    selected = newValue;
                    widget.onFirmSelected(selected);
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
