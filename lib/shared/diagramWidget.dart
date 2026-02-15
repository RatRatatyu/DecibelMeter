import 'package:flutter/material.dart';
import 'package:sound_metter/uiStyle/imageAsset.dart';
import 'package:sound_metter/uiStyle/style.dart';
import 'package:sound_metter/noise/poinerIndicate.dart';

class diagramWidget extends StatelessWidget {
  const diagramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const ImageAssets(image: "assets/diagram.jpg", x: 0.9),
            Positioned(bottom: uiSize(context, 0.28),child: AnimatePointer())
          ],
        )
      ],
    );
  }
}
