import 'package:flutter/material.dart';
import 'dart:async';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:fl_chart/fl_chart.dart';


class NoiseProvider extends ChangeNotifier{
  NoiseMeter? _noiseMeter;
  StreamSubscription<NoiseReading>? _subscription;

  double maxDb = 0;
  double avgDb = 0;
  double peakDb = 0;
  double callibrationOffset = -20;
  double db = 0;


  bool isRecording = false;

  DateTime _lastUiUpdate =DateTime.now();
  final Duration _updateInterval = const Duration(milliseconds: 200); //5 раз в секунду

  final int _windowSize = 20;
  List<double> window = [];
  List<FlSpot> windowFlSpots = [];




  Future<void> start() async {
    WakelockPlus.enable();
    if (isRecording) return;
    final status = await Permission.microphone.request();
    if (!status.isGranted) return;

    _reset();

    _noiseMeter ??= NoiseMeter();
    _subscription = _noiseMeter!.noise.listen(_onData, onError: _onError);

    isRecording = true;
    notifyListeners();
  }

  void stop() {
    _subscription?.cancel();
    WakelockPlus.disable();
    isRecording = false;
    notifyListeners();
  }

  void _onData(NoiseReading reading) {
    final rawDb = reading.meanDecibel;
    if (!rawDb.isFinite) return;

    db = rawDb + callibrationOffset;
    final safeDb = db.clamp(-100.0, 120.0);

    const alpha = 0.1;
    peakDb = peakDb.isFinite ? alpha * safeDb + (1 - alpha) * peakDb : db;

    if (peakDb > maxDb) maxDb = peakDb;

    window = List.from(window)..add(safeDb);
    if(window.length > _windowSize){
      window.removeAt(0);
    }
    windowFlSpots = window
        .asMap()
        .entries
        .map((entry) => FlSpot(
      entry.key.toDouble(),
      entry.value,
    )).toList();


    final sum = window.reduce((a,b) => a+b);
    avgDb = sum / window.length;



    final now = DateTime.now();
    if(now.difference(_lastUiUpdate) > _updateInterval){
      _lastUiUpdate = now;
      notifyListeners();
    }
  }

  void _onError(Object e) {
    stop();
  }

  void _reset() {
    maxDb = 0;
    avgDb = 0;
    peakDb = 0;
    db = 0;
    _lastUiUpdate = DateTime.now();
    window.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    stop();
    super.dispose();
  }
}