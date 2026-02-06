import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/style.dart';


class Indications extends StatefulWidget{
  const Indications({super.key});

  @override
  State<Indications> createState() => _Indications();

}
class _Indications extends State<Indications> {

  @override
  void initState(){

    WidgetsBinding.instance.addPostFrameCallback((_){
      if (mounted) context.read<NoiseProvider>().start();
  });
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Max", style: TextStyle(
                        fontSize: textSize(context, 0.03), color: Colors.white),),
                    Selector<NoiseProvider, double>(
                        selector: (_,p) => p.maxDb,
                        builder: (_,value, __){
                          return Text(value > 0  ? "${value.toStringAsFixed(0)} dB" : "", style: TextStyle(
                              fontSize: textSize(context, 0.05), color: Colors.white),);
                        }
                    )
                  ],
                ),
                Column(
                  children: [
                    Text("Avg", style: TextStyle(
                        fontSize: textSize(context, 0.03), color: Colors.white),),
                    Selector<NoiseProvider, double>(
                      selector: (_,p) => p.avgDb,
                      builder: (_,value, __) {
                        return Text(value > 0 ? "${value
                            .toStringAsFixed(0)} dB" : "", style: TextStyle(
                            fontSize: textSize(context, 0.05),
                            color: Colors.white),);
                      },
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Text("Peak", style: TextStyle(
                fontSize: textSize(context, 0.03), color: Colors.white),),
            Selector<NoiseProvider, double>(
              selector: (_,p) => p.peakDb,
              builder: (_,value, __) {
                return Text(
                  value > 0  ? "${value.toStringAsFixed(
                      0)} dB" : "", style: TextStyle(
                    fontSize: textSize(context, 0.07), color: Colors.white),);
              },
            ),
          ],
        ),
      );
  }
}
