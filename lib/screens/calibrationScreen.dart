import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/shared/diagramWidget.dart';
import 'package:sound_metter/noise/peakIndication.dart';
import 'package:sound_metter/uiStyle/style.dart';
import 'package:sound_metter/state/noisePrividerState.dart';


class calibrationDb extends StatelessWidget {
  const calibrationDb({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
          size: uiSize(context, 0.06),
        ),
        backgroundColor: colorScheme.primary,
        title: Text("Calibration", style: TextStyle(fontSize: textSize(context, 0.05), color: Colors.white),),
      ),

      body: Column(
            children: [
              SizedBox(height: 16,),
              diagramWidget(),
              SizedBox(height: 16,),
              PeakIndicate(),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Ink(
                    decoration: ShapeDecoration(
                        color: colorScheme.primary,
                      shape: CircleBorder()
                    ),
                    child: IconButton(
                      onPressed: () {
                        context.read<NoiseProvider>().increaseCalibration();
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      iconSize: uiSize(context, 0.09),
                    ),
                  ),
                  Selector<NoiseProvider, double>(
                    selector: (_, p) => p.callibrationOffset,
                    builder: (_, value, __) => Text(
                      value.toString(),
                      style: TextStyle(fontSize: textSize(context, 0.05), color: Colors.white),
                    ),
                  ),
                  Ink(
                    decoration: ShapeDecoration(
                        color: colorScheme.primary,
                        shape: CircleBorder()
                    ),
                    child: IconButton(
                    onPressed: () {
                      context.read<NoiseProvider>().decreaseCalibration();
                    },
                    icon: Icon(Icons.remove),
                    color: Colors.white,
                    iconSize: uiSize(context, 0.09),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1,),
              Ink(
                decoration: ShapeDecoration(
                    color: colorScheme.primary,
                    shape: CircleBorder()
                ),
                child: IconButton(
                  onPressed: () {
                    context.read<NoiseProvider>().resetCalibration();
                  },
                  icon: Icon(Icons.refresh_sharp),
                  color: Colors.white,
                  iconSize: uiSize(context, 0.09),
                ),
              ),
              Spacer(flex: 2,)
            ],

          ),
      backgroundColor: backgroundColor,
    );
  }
}


