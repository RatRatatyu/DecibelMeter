import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/style.dart';


class PeakIndicate extends StatelessWidget{
  const PeakIndicate({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:Column(
          children: [
            Selector<NoiseProvider, double>(
              selector: (_,p) => p.peakDb,
              builder: (_,value, __) {
                return Text(
                  value > 0  ? "${value.toStringAsFixed(
                      0)} dB" : "", style: TextStyle(
                    fontSize: textSize(context, 0.07), color: Colors.white),);
              },
            ),
            Text("Peak", style: TextStyle(
                fontSize: textSize(context, 0.03), color: Colors.white),),
          ],
        ),
      );
  }
}
