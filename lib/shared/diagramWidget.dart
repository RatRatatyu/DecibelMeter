import 'package:flutter/material.dart';
import 'package:sound_metter/adaptationWidgets/appLayout.dart';
import 'package:sound_metter/noise/poinerIndicate.dart';

  class diagramWidget extends StatelessWidget {
    const diagramWidget({super.key});

    @override
    Widget build(BuildContext context) {
      final layout = LayoutProvider.of(context);

      return Padding(
        padding: EdgeInsets.all(layout.sizes.m),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/diagram.jpg",
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  const Positioned(
                    child: AnimatePointer(),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

