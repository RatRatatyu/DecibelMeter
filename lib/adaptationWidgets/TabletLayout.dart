import 'package:flutter/material.dart';
import 'package:sound_metter/noise/peakIndication.dart';
import 'package:sound_metter/noise/graphDb.dart';
import 'package:sound_metter/noise/othersIndicates.dart';
import 'package:sound_metter/shared/diagramWidget.dart';

class TabletLayout extends StatelessWidget {
  const TabletLayout({super.key});
  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if(isLandscape){
      return  Row(
        children: [
          Expanded(
            flex: 1,
            child: diagramWidget(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2,),
                PeakIndicate(),
                Expanded(
                  flex: 3,
                  child: graphicDb(),
                ),
                othersIndications(),
              ],
            ),
          ),
        ],
      );
    }else{
      return Column(
        children: [
          Expanded(
            flex: 3,
            child: diagramWidget(),
          ),
          PeakIndicate(),
          Expanded(
            flex: 2,
            child: graphicDb(),
          ),
          othersIndications(),

        ],
      );
    }

  }
}
