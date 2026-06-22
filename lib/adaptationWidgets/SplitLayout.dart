import "package:flutter/material.dart";
import 'package:sound_metter/noise/peakIndication.dart';
import 'package:sound_metter/noise/othersIndicates.dart';
import 'package:sound_metter/shared/diagramWidget.dart';

class SplitLayout extends StatelessWidget {
  const SplitLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: diagramWidget(),
        ),
        PeakIndicate(),
        othersIndications(),

      ],
    );
  }
}
