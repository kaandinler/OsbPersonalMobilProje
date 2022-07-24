import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/ui/firms_widget.dart';
import 'package:flutter_application_1/ui/my_index_textfield_widget.dart';

class IndexBilgisiGir extends StatefulWidget {
  const IndexBilgisiGir({Key? key}) : super(key: key);

  @override
  State<IndexBilgisiGir> createState() => _IndexBilgisiGirState();
}

class _IndexBilgisiGirState extends State<IndexBilgisiGir> {
  String selectedFirm = "";
  String _index1 = '', _index2 = '', _index3 = '', _index4 = '';
  bool _index2Visible = false;
  bool _index3Visible = false;
  bool _index4Visible = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(227, 242, 253, 1),
        appBar: AppBar(
          title: Text(
            'Midsoft Index Bilgisi Kayıt',
            style: TextStyle(color: Colors.black38),
          ),
          backgroundColor: Color.fromRGBO(227, 242, 253, 1),
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
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FirmsWidget(onFirmSelected: (onFirmSelected) {
                      selectedFirm = onFirmSelected;
                    }),
                    horizontalSpaceMedium,
                    MyIndexTextFieldWidget(
                      index_sayisi: 'Birinci Index',
                    ),
                    Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: _index2Visible,
                        child: MyIndexTextFieldWidget(
                          index_sayisi: 'İkinci Index',
                        )),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _index3Visible,
                      child: MyIndexTextFieldWidget(
                        index_sayisi: 'Üçüncü Index',
                      ),
                    ),
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: _index4Visible,
                      child: MyIndexTextFieldWidget(
                        index_sayisi: 'Dördüncü Index',
                      ),
                    ),
                    FloatingActionButton.extended(
                        heroTag: "SaveIndexData",
                        onPressed: () {},
                        icon: Icon(Icons.save),
                        label: Text(
                          'Kaydet',
                        )),
                  ]),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "addTextField",
          onPressed: () {
            if (_index4Visible) return;

            setState(() {
              if (!_index2Visible) {
                _index2Visible = true;
              } else if (!_index3Visible) {
                _index3Visible = true;
              } else {
                _index4Visible = true;
              }
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
