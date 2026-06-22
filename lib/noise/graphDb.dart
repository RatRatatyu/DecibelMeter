import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sound_metter/state/noisePrividerState.dart';
import 'package:provider/provider.dart';
import 'package:sound_metter/adaptationWidgets/appLayout.dart';

class graphicDb extends StatefulWidget {
  const graphicDb({super.key});

  @override
  State<graphicDb> createState() => _graphicDbState();
}

class _graphicDbState extends State<graphicDb> {

  @override
  Widget build(BuildContext context) {
    var layout = LayoutProvider.of(context);

    var bodyS = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Colors.white
    );

    return Selector<NoiseProvider, List<FlSpot>>(
        selector: (_, provider) => provider.windowFlSpots,
        builder: (_, spots, __) {
          if (spots.isEmpty) return const Spacer();

          return Container(
            margin: EdgeInsets.all(layout.sizes.xs),
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
                        preventCurveOverShooting: true,
                        color: Colors.deepPurple,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple.withAlpha(80),
                              Colors.purple.withAlpha(80),
                              Colors.blueAccent.withAlpha(80)
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
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 20,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: EdgeInsets.only(right: layout.sizes.s),
                            child: Text(
                              value.toInt().toString(),
                              style: bodyS,
                              textAlign: TextAlign.right,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                borderData: FlBorderData(show: false),
              ),
            ),
          );
        },
    );
  }
}
