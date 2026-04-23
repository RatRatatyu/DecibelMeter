import 'package:flutter/material.dart';
import 'package:sound_metter/noise/poinerIndicate.dart';

class diagramWidget extends StatelessWidget {
  const diagramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/diagram.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
               Positioned(
                child: AnimatePointer(),
              ),
            ],
          ),
    );

  }
}
