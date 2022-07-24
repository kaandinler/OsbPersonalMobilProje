import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/modal/firm_all_information_modal.dart';
import 'package:flutter_application_1/modal/firm_modal.dart';
import 'package:flutter_application_1/shared/ui_helpers.dart';
import 'package:flutter_application_1/web_api/my_http_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FirmaCihazListesi extends StatefulWidget {
  const FirmaCihazListesi({Key? key}) : super(key: key);

  @override
  State<FirmaCihazListesi> createState() => _FirmaCihazListesiState();
}

class _FirmaCihazListesiState extends State<FirmaCihazListesi> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Color.fromRGBO(227, 242, 253, 1),
      appBar: AppBar(
        title: Text(
          'Firma Adı Ara',
          style: TextStyle(color: Colors.black38),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MySearchBar());
            },
          )
        ],
        backgroundColor: Color.fromRGBO(227, 242, 253, 1),
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        iconTheme: IconThemeData(
          color: Colors.black38, //change your color here
        ),

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
                  children: [])
            ]),
      ),
    ));
  }
}

class MySearchBar extends SearchDelegate {
  // List<String> searchResults = ['Kaan', 'Deneme', 'Texas', 'Programming'];
  // List<String> searchResults = () {
  //   HttpService httpService = HttpService();
  //   Future<List<Firm>> firmaListesi = httpService.getPosts();
  //   List<String> firmaAdlari = [];
  //   firmaListesi.then((value) {
  //     for (Firm firm in value) {
  //       firmaAdlari.add(firm.firmName);
  //     }
  //   });
  //   return firmaAdlari;
  // }();

  String mySearchFirmOid = '';
  late FirmDetail _firmDetail;

  List<Firm> searchResults = () {
    HttpService httpService = HttpService();
    Future<List<Firm>> firmaListesi = httpService.getPosts();
    List<Firm> firmaAdlari = [];
    firmaListesi.then((value) {
      for (Firm firm in value) {
        firmaAdlari.add(firm);
      }
    });
    return firmaAdlari;
  }();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        }
        query = '';
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults

    HttpService httpService = HttpService();
    FutureBuilder<FirmDetail> futureBuilder = FutureBuilder<FirmDetail>(
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          _firmDetail = snapshot.data!;
          return Center(
            child: Text(_firmDetail.firmName.toString()),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      future: httpService.getFirmDetail(mySearchFirmOid),
    );

    _firmDetail = () {
      HttpService httpService = HttpService();
      FutureBuilder<FirmDetail> futureBuilder = FutureBuilder<FirmDetail>(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            _firmDetail = snapshot.data!;
            return Center(
              child: Text(_firmDetail.firmName.toString()),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
        future: httpService.getFirmDetail(mySearchFirmOid),
      );

      // HttpService httpService = HttpService();
      // Future<FirmDetail> firm = httpService.getFirmDetail(mySearchFirmOid);
      // FirmDetail firmDet = FirmDetail(
      //     firmName: 'Deneme',
      //     firmAddress: '',
      //     Oid: '',
      //     deviceIsPluggedIn: false,
      //     deviceSerial: '',
      //     isDeviceActive: false,
      //     latitude: 0.0,
      //     longitude: 0.0,
      //     meter: '',
      //     meterModal: '',
      //     meterIsSuitable: false,
      //     pulseCounter: false);
      // firm.then((value) {
      //   firmDet = value;
      // });
      return _firmDetail;
    }();

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
              Text('Firma Adi: ' + _firmDetail.firmName.toString()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    // List<String> suggestions = searchResults.where((String suggestion) {
    //   return suggestion.toLowerCase().contains(query.toLowerCase());
    // }).toList();

    // List<String> suggestions = searchResults.map((Firm firm) {
    //   return firm.firmName.toLowerCase();
    // }).toList();

    List<Firm> suggestions = searchResults.where((Firm suggestion) {
      return suggestion.firmName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final String suggestion = suggestions.elementAt(index).firmName;
        final String suggestionOid = suggestions.elementAt(index).Oid;
        return ListTile(
          title: Text(suggestion),
          onTap: () {
            // query = suggestion;
            mySearchFirmOid = suggestionOid;
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
