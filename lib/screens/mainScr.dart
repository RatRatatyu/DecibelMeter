import 'package:flutter/material.dart';
import 'package:sound_metter/uiStyle/imageAsset.dart';
import 'package:sound_metter/peakIndication.dart';
import 'package:sound_metter/screens/infoPage.dart';
import 'package:sound_metter/uiStyle/style.dart';
import 'package:sound_metter/poinerIndicate.dart';
import 'package:sound_metter/graphDb.dart';
import 'package:sound_metter/othersIndicates.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context){
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: uiSize(context, 0.06),
          color: Colors.white,
        ),
          backgroundColor: colorScheme.primary,
          title: Text("Decibel Meter", style: TextStyle(fontSize: textSize(context, 0.05), color: Colors.white),),
          actions: [
            IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute<void>(
              builder: (context) => const InfoPage(),
            )), icon: Icon(Icons.lightbulb), color: Colors.yellow, iconSize: uiSize(context, 0.06),)
          ],
        ),
        drawer: Drawer(
          backgroundColor: backgroundColor,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: colorScheme.primary),
                child: ImageAssets(image: "assets/diagram.jpg", x: 0.03),
              ),

              ListTile(
                leading: Icon(Icons.mic, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("calibration", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute<void>(
                    builder: (context) => const InfoPage(),
                  ));
                }
              ),

              ListTile(
                leading: Icon(Icons.language, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Language", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (context) => const InfoPage(),
                    ));
                  }
              ),

              ListTile(
                leading: Icon(Icons.safety_check, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Privacy Policy", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (context) => const InfoPage(),
                    ));
                  }
              ),

              ListTile(
                leading: Icon(Icons.share, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Share", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (context) => const InfoPage(),
                    ));
                  }
              ),
            ],
          ),
        ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const ImageAssets(image: "assets/diagram.jpg", x: 0.9),
                  Positioned(bottom: uiSize(context, 0.30),child: AnimatePointer())
                ],
              )
            ],
          ),
         SizedBox(height: 18,),
          PeakIndicate(),
          graphicDb(),
          othersIndications(),
          Spacer(flex: 1,),
          SizedBox(
            height: 75,
            child: Placeholder(), //for advertising
          )


        ],
      ),
      backgroundColor: backgroundColor,
    );
  }
}
