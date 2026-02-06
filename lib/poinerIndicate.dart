import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:sound_metter/uiStyle/imageAsset.dart';

class Pointer extends StatelessWidget{
  const Pointer({super.key, required this.angle});

  final double angle;

  @override
  Widget build(BuildContext context){
    return Transform.rotate(
      angle: angle,
      alignment: Alignment.bottomCenter,
      child: ImageAssets(image: "assets/pointer.png", x:0.9),

    );
  }
}

double mapDbToAngle(double db) {
  const minDb = 0.0;
  const maxDb = 120.0;

  const minAngle = -130 * pi / 180;
  const maxAngle =  130 * pi / 180;

  final clampedDb = db.clamp(minDb, maxDb);

  return minAngle + (clampedDb - minDb) / (maxDb - minDb) * (maxAngle - minAngle);
}


class AnimatePointer extends StatefulWidget {
  const AnimatePointer({super.key});

  @override
  State<AnimatePointer> createState() => _AnimatePointerState();
}

class _AnimatePointerState extends State<AnimatePointer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Tween<double> _angleTween;
  late final Animation<double> _curvedAnimation;

  double _currentSmoothedAngle = mapDbToAngle(0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _angleTween = Tween<double>(begin: _currentSmoothedAngle, end: _currentSmoothedAngle);

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDbChange(double db) {
    final targetAngle = mapDbToAngle(db);

    const alpha = 0.2;
    final nextAngle = alpha * targetAngle + (1 - alpha) * _currentSmoothedAngle;

    if ((nextAngle - _currentSmoothedAngle).abs() < 0.001) return;

    _angleTween.begin = _currentSmoothedAngle;
    _angleTween.end = nextAngle;

    _currentSmoothedAngle = nextAngle;

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<NoiseProvider, double>(
      selector: (_, provider) => provider.peakDb,
      builder: (_, value, _) {
        _handleDbChange(value);

        return AnimatedBuilder(
          animation: _curvedAnimation,
          builder: (_, _) {
            return Pointer(angle: _angleTween.evaluate(_curvedAnimation));
          },
        );
      },
    );
  }
}
