import 'package:flutter/material.dart';

class Musichome extends StatefulWidget {
  @override
  _MusichomeState createState() => _MusichomeState();
}

class _MusichomeState extends State<Musichome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[700],
        title: Text('Music'),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              color: Colors.white54,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
            )
          ],
        ),
      ),
    );
  }
}