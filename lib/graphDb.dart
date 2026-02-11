import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:provider/provider.dart';

class graphicDb extends StatefulWidget {
  const graphicDb({super.key});

  @override
  State<graphicDb> createState() => _graphicDbState();
}

class _graphicDbState extends State<graphicDb> {

  @override
  Widget build(BuildContext context) {
    return Selector<NoiseProvider, List<FlSpot>>(
        selector: (_, provider) => provider.windowFlSpots,
        builder: (_, spots, __) {
          if (spots.isEmpty) return const Spacer();

          return AspectRatio(
            aspectRatio: 2.0,
            child: LineChart(
                LineChartData(
                    minY: 0,
                    maxY: 120,
                    maxX: spots.last.x,
                    minX: spots.first.x,
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: Colors.deepPurple,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: const LinearGradient(
                          colors: [
                          Colors.deepPurple,
                          Colors.purple,
                          Colors.blueAccent
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        ),
                        dotData: FlDotData(
                          show: false,
                        )
                      ),
                    ],
                  gridData: FlGridData(
                    show: false
                  ),
                  lineTouchData: LineTouchData(enabled: false),

                ),
            ),
          );
        }
    );
  }


}
