import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';

class MyIndexTextFieldWidget extends StatefulWidget {
  final String index_sayisi;
  const MyIndexTextFieldWidget({Key? key, required this.index_sayisi})
      : super(key: key);

  @override
  State<MyIndexTextFieldWidget> createState() => _MyIndexTextFieldWidgetState();
}

class _MyIndexTextFieldWidgetState extends State<MyIndexTextFieldWidget> {
  var textFields = <MyIndexTextFieldWidget>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpaceTiny,
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.index_sayisi,
            ),
            onChanged: (text) {},
          ),
        ],
      ),
    );
  }
}
