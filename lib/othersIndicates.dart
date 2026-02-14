import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/style.dart';


class othersIndications extends StatelessWidget{
  const othersIndications({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Selector<NoiseProvider, double>(
                        selector: (_,p) => p.maxDb,
                        builder: (_,value, __){
                          return Text(value > 0  ? "${value.toStringAsFixed(0)} dB" : "", style: TextStyle(
                              fontSize: textSize(context, 0.05), color: Colors.white),);
                        }
                    ),
                    Text("Max", style: TextStyle(
                        fontSize: textSize(context, 0.03), color: Colors.white),),
                  ],
                ),
                Column(
                  children: [
                    Selector<NoiseProvider, double>(
                      selector: (_,p) => p.avgDb,
                      builder: (_,value, __) {
                        return Text(value > 0 ? "${value
                            .toStringAsFixed(0)} dB" : "", style: TextStyle(
                            fontSize: textSize(context, 0.05),
                            color: Colors.white),);
                      },
                    ),
                    Text("Avg", style: TextStyle(
                        fontSize: textSize(context, 0.03), color: Colors.white),),
                  ],
                )
              ],
            ),
          ],
        ),
      );
  }
}
