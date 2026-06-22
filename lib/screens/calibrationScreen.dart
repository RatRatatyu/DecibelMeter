import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/shared/diagramWidget.dart';
import 'package:sound_metter/noise/peakIndication.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/adaptationWidgets/appLayout.dart';
class CalibrationScreen extends StatelessWidget {
  const CalibrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    final layout = LayoutProvider.of(context);

    final titleL = Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white, size: layout.sizes.iconMd),
        backgroundColor: colorScheme.primary,
        title: Text("Calibration", style: titleL),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: diagramWidget(),
          ),
          PeakIndicate(),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCircleButton(context, Icons.add, () => context.read<NoiseProvider>().increaseCalibration()),
              Selector<NoiseProvider, double>(
                selector: (_, p) => p.callibrationOffset,
                builder: (_, value, __) => Text(
                  "${value.toStringAsFixed(1)} dB",
                  style: titleL,
                ),
              ),

              _buildCircleButton(context, Icons.remove, () => context.read<NoiseProvider>().decreaseCalibration()),
            ],
          ),
          const Spacer(flex: 1),
          _buildCircleButton(context, Icons.refresh_sharp, () => context.read<NoiseProvider>().resetCalibration()),
          const Spacer(flex: 2),
        ],
      ),
      backgroundColor: backgroundColor,
    );
  }


  Widget _buildCircleButton(BuildContext context, IconData icon, VoidCallback onPressed) {
    final colorScheme = Theme.of(context).colorScheme;
    final layout = LayoutProvider.of(context);

    return Ink(
      decoration: ShapeDecoration(
        color: colorScheme.primary,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: Colors.white,
        iconSize: layout.sizes.iconMd,
      ),
    );
  }
}
