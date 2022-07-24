import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EslestirmeSonucuWidget extends StatefulWidget {
  final String eslestirmeSonucu;
  const EslestirmeSonucuWidget(this.eslestirmeSonucu, {Key? key})
      : super(key: key);

  @override
  State<EslestirmeSonucuWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EslestirmeSonucuWidget> {
  var eslesmeSonucuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 15),
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          controller: eslesmeSonucuController,
          readOnly: true,
          autocorrect: false,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "${widget.eslestirmeSonucu}",
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.redAccent),
              labelText: 'Cihaz ve Firma Eşleştirmesi Sonucu ',
              labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
        ));
  }
}
