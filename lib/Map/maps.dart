import 'package:app_segpar/Login/welcome.dart';
import 'package:app_segpar/TodoList/draw.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsF extends StatefulWidget {
  const MapsF({Key? key}) : super(key: key);

  @override
  _MapsFState createState() => _MapsFState();
}

class _MapsFState extends State<MapsF> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7749, -122.4194);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const HomeDraw()),
                ),
              );
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MapsF(),
  ));
}
