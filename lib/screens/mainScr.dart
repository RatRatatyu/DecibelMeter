import 'package:flutter/material.dart';
import 'package:sound_metter/uiStyle/imageAsset.dart';
import 'package:sound_metter/noise/peakIndication.dart';
import 'package:sound_metter/uiStyle/style.dart';
import 'package:sound_metter/noise/graphDb.dart';
import 'package:sound_metter/noise/othersIndicates.dart';
import 'package:sound_metter/shared/diagramWidget.dart';

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
            IconButton(onPressed: () => Navigator.restorablePushNamed(context, '/info'),
            icon: Icon(Icons.lightbulb), color: Colors.yellow, iconSize: uiSize(context, 0.06),)
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
                  Navigator.restorablePushNamed(context, '/calibarte');
                }
              ),

              ListTile(
                leading: Icon(Icons.language, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Language", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);
                   Navigator.restorablePushNamed(context, '/languageCh');
                  }
              ),

              ListTile(
                leading: Icon(Icons.safety_check, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Privacy Policy", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);

                  }
              ),

              ListTile(
                leading: Icon(Icons.share, color: Colors.white, size: uiSize(context, 0.05),),
                title:  Text("Share", style: TextStyle(fontSize: textSize(context, 0.04), color: Colors.white),),
                  onTap: () {
                    Navigator.pop(context);

                  }
              ),
            ],
          ),
        ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          diagramWidget(),
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
