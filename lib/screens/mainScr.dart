import 'package:flutter/material.dart';
import 'package:sound_metter/adaptationWidgets/appLayout.dart';
import "package:sound_metter/adaptationWidgets/MobileLayout.dart";
import 'package:sound_metter/adaptationWidgets/TabletLayout.dart';
import 'package:sound_metter/adaptationWidgets/SplitLayout.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context){
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    final layout = LayoutProvider.of(context);
    final titleL = Theme.of(context).textTheme.titleLarge?.copyWith(
      color: Colors.white,
    );
    final titleM = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Colors.white,
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: layout.sizes.iconMd,
          color: Colors.white,
        ),
        backgroundColor: colorScheme.primary,
        title: Text("Decibel Meter", style: titleL),
        actions: [
          IconButton(onPressed: () => Navigator.restorablePushNamed(context, '/info'),
            icon: Icon(Icons.lightbulb), color: Colors.yellow, iconSize: layout.sizes.iconMd,)
        ],
      ),
      drawer: Drawer(
        backgroundColor: backgroundColor,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: colorScheme.primary),
              child: Placeholder(),
            ),

            ListTile(
                leading: Icon(Icons.mic, color: Colors.white, size: layout.sizes.iconSm,),
                title:  Text("calibration", style: titleM),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.restorablePushNamed(context, '/calibration');
                }
            ),

            ListTile(
                leading: Icon(Icons.language, color: Colors.white, size: layout.sizes.iconSm,),
                title:  Text("Language", style: titleM),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.restorablePushNamed(context, '/languageCh');
                }
            ),

            ListTile(
                leading: Icon(Icons.safety_check, color: Colors.white, size: layout.sizes.iconSm,),
                title:  Text("Privacy Policy", style: titleM),
                onTap: () {
                  Navigator.pop(context);

                }
            ),

            ListTile(
                leading: Icon(Icons.share, color: Colors.white, size: layout.sizes.iconSm,),
                title:  Text("Share", style: titleM),
                onTap: () {
                  Navigator.pop(context);

                }
            ),
          ],
        ),
      ),
      body: switch (layout.type) {
        LayoutType.expanded => const TabletLayout(),
        LayoutType.medium   => const MobileLayout(),
        LayoutType.compact  => const SplitLayout(),
      },
      backgroundColor: backgroundColor,
    );
  }
}







