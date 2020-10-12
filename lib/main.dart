import 'package:flutter/material.dart';
import 'package:muvi/Videoplayer/Home.dart';

void main() {
  runApp(MaterialApp(theme: ThemeData.dark(),home: Home(),));
}

var wid;
var len;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    wid = MediaQuery.of(context).size.width;
    len =  MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: wid,
        height: len,
        //color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text('MIVI', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 80),),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              MaterialButton(
                color: Colors.red[600],
                child: Text('Music'),
                onPressed: (){
                  print('Music');
                },
              ),
              SizedBox(width: 20,), 
              MaterialButton(
                color: Colors.red[600],
                child: Text('Video'),
                onPressed: (){
                  print("Video");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => VideHome()));
                },
              )
            ],)
          ],
        ),
      ),
    );
  }
}