import 'package:flutter/material.dart';
import 'package:flutter_application_1/modal/firm_modal.dart';
import 'package:flutter_application_1/modal/locations.dart' as firms;
import 'package:flutter_application_1/web_api/my_http_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CihazHaritasi extends StatefulWidget {
  const CihazHaritasi({Key? key}) : super(key: key);

  @override
  State<CihazHaritasi> createState() => _CihazHaritasiState();
}

class _CihazHaritasiState extends State<CihazHaritasi> {
  final Map<String, Marker> _markers = {};
  dynamic firmLocations;

  MapType _currentMapType = MapType.normal;
  void _onToggleMapTypePressed() {
    final nextType =
        MapType.values[(_currentMapType.index + 1) % MapType.values.length];

    setState(() {
      _currentMapType = nextType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Cihaz Haritası',
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
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              mapType: _currentMapType,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(39.752605, 30.635190),
                zoom: 15,
              ),
              markers: _markers.values.toSet(),
            ),
            _MapFabs(
              onToggleMapTypePressed: _onToggleMapTypePressed,
              visible: true,
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // final googleOffices = await firms.getFirmsLocation();
    firmLocations = await firms.getFirmsLocation();

    setState(() {
      double lat = 0.0;
      double lng = 0.0;
      _markers.clear();
      for (final firm in firmLocations.getFirmAndLocationResult) {
        lat = double.parse(firm.latitude);
        lng = double.parse(firm.longitude);

        if (firm.sayacuygun == false || firm.sayacuygun == 'false') {
          _markers[firm.firmName] = Marker(
            markerId: MarkerId(firm.firmName),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: firm.firmName,
              snippet: firm.address,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen),
          );
        } else {
          _markers[firm.firmName] = Marker(
            markerId: MarkerId(firm.firmName),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: firm.firmName,
              snippet: firm.address,
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          );
        }
      }
    });
  }

  // build list view & manage states
  FutureBuilder<List<Firm>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<Firm>>(
      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Firm>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  ListView _buildPosts(BuildContext context, List<Firm> posts) {
    return ListView.builder(
      // itemCount: posts.length,
      itemCount: 1,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].Oid.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].firmName.toString()),
          ),
        );
      },
    );
  }
}

class _MapFabs extends StatelessWidget {
  final bool visible;
  final VoidCallback onToggleMapTypePressed;

  const _MapFabs({
    required this.visible,
    required this.onToggleMapTypePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 20.0, right: 12.0),
      child: Visibility(
        visible: visible,
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            FloatingActionButton(
              heroTag: 'toggle_map_type_button',
              onPressed: onToggleMapTypePressed,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              mini: true,
              backgroundColor: Colors.blue,
              child: const Icon(Icons.layers, size: 28.0),
            ),
          ],
        ),
      ),
    );
  }
}
