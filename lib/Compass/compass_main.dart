import 'dart:math';
import 'package:app_segpar/Camara/camara.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Comp(),
    );
  }
}

class Comp extends StatefulWidget {
  const Comp({super.key});

  @override
  State<Comp> createState() => _CompState();
}

class _CompState extends State<Comp> {
  double? heading = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterCompass.events!.listen((event) {
      setState(() {
        heading = event.heading;
      });
    });
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
                  builder: ((context) => const HomeCamara()),
                ),
              );
            },
          ),
        ],
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text('Compass'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${heading!.ceil()}°",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 50.0),
          Padding(
              padding: EdgeInsets.all(18.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/compass.png'),
                  Transform.rotate(angle: ((heading ?? 0) * (pi / 180) * -1))
                ],
              )),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}
