import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/adaptationWidgets/appLayout.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/style.dart';


class othersIndications extends StatelessWidget{
  const othersIndications({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = LayoutProvider.of(context);
    final  headLineS = Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: Colors.white,
    );
    final titleM = Theme.of(context).textTheme.titleMedium?.copyWith(
      color: Colors.white,
    );

    return Padding(
        padding: EdgeInsets.all(layout.sizes.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Selector<NoiseProvider, double>(
                    selector: (_,p) => p.maxDb,
                    builder: (_,value, __){
                      return Text(value > 0  ? "${value.toStringAsFixed(0)} dB" : "", style: headLineS);
                    }
                ),
                Text("Max", style: titleM),
              ],
            ),
            Column(
              children: [
                Selector<NoiseProvider, double>(
                  selector: (_,p) => p.avgDb,
                  builder: (_,value, __) {
                    return Text(value > 0 ? "${value
                        .toStringAsFixed(0)} dB" : "", style: headLineS);
                  },
                ),
                Text("Avg", style: titleM),
              ],
            )
          ],
        ),
    );
  }
}
