import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/style.dart';


class PeakIndicate extends StatelessWidget{
  const PeakIndicate({super.key});

  @override
  Widget build(BuildContext context) {
    final  headLineM = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: Colors.white,
    );
    final titleM = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Colors.white,
    );
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
                      0)} dB" : "", style: headLineM);
              },
            ),
            Text("Peak", style: titleM),
          ],
        ),
      );
  }
}
