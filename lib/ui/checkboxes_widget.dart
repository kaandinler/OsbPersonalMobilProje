import 'package:flutter/material.dart';

class CheckBoxesWidget extends StatefulWidget {
  final Function onCihazTakildiChanged;
  final Function onManyetikSwitchChanged;
  final Function onSayacUygunDegilChanged;
  const CheckBoxesWidget(
      {Key? key,
      required this.onCihazTakildiChanged,
      required this.onManyetikSwitchChanged,
      required this.onSayacUygunDegilChanged})
      : super(key: key);

  @override
  State<CheckBoxesWidget> createState() => _CheckBoxesWidgetState();
}

class _CheckBoxesWidgetState extends State<CheckBoxesWidget> {
  bool manyetikSwitchVar = false;
  bool sayacUygunDegil = false;
  bool cihazTakildi = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                blurRadius: 5) //blur radius of shadow
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: CheckboxListTile(
              title: const Text('Cihaz TAKILDI',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54)),
              value: cihazTakildi,
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.green,
              onChanged: (bool? value) {
                setState(() {
                  cihazTakildi = value!;
                  widget.onCihazTakildiChanged(cihazTakildi);
                });
              },
              secondary: const Icon(
                Icons.cable_outlined,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: CheckboxListTile(
              title: const Text(
                'Manyetik Switch VAR',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              value: manyetikSwitchVar,
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.green,
              onChanged: (bool? value) {
                setState(() {
                  manyetikSwitchVar = value!;
                  widget.onManyetikSwitchChanged(manyetikSwitchVar);
                });
              },
              secondary: const Icon(
                Icons.cable_outlined,
                color: Colors.black54,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: CheckboxListTile(
              title: const Text(
                'Sayaç Uygun DEĞİL',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold),
              ),
              value: sayacUygunDegil,
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              activeColor: Colors.red,
              onChanged: (bool? value) {
                setState(() {
                  sayacUygunDegil = value!;
                  widget.onSayacUygunDegilChanged(sayacUygunDegil);
                });
              },
              secondary: const Icon(
                Icons.cable_outlined,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
