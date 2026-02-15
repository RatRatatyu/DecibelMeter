import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/state/noisePrividerState.dart';


class PointerPainter extends CustomPainter {
  final double angle;

  PointerPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);
    canvas.translate(-center.dx, -center.dy);


    final path = Path();
    path.moveTo(size.width * 0.4, size.height);
    path.lineTo(size.width * 0.6, size.height);
    path.lineTo(size.width * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(center, size.width * 0.4, paint..color = Colors.black);
    canvas.drawCircle(center, size.width * 0.2, paint..color = Colors.grey);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PointerPainter oldDelegate) {
    return oldDelegate.angle != angle;
  }
}

class Pointer extends StatelessWidget {
  const Pointer({super.key, required this.angle});
  final double angle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 140,
      child: CustomPaint(
        painter: PointerPainter(angle: angle),
      ),
    );
  }
}

double mapDbToAngle(double db) {
  const minDb = 0.0;
  const maxDb = 120.0;

  const minAngle = -120 * pi / 180;
  const maxAngle =  120 * pi / 180;

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
      duration: const Duration(milliseconds: 20),
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

    final nextAngle =  targetAngle;

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
