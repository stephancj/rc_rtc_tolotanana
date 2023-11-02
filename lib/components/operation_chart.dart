import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OperationChart extends StatefulWidget {
  const OperationChart({super.key});

  @override
  State<OperationChart> createState() => _OperationChartState();
}

class _OperationChartState extends State<OperationChart> {
  List<_OperationData> data = [
    _OperationData('Jan', 35),
    _OperationData('Feb', 28),
    _OperationData('Mar', 34),
    _OperationData('Apr', 32),
    _OperationData('May', 40)
  ];

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
        title: ChartTitle(text: 'Nombres d\'opérations par type'),
        legend: const Legend(isVisible: true),
        series: <CircularSeries>[
          // Render pie chart
          PieSeries<_OperationData, String>(
            dataSource: data,
            pointColorMapper: (_OperationData data, _) => data.color,
            xValueMapper: (_OperationData data, _) => data.operation,
            yValueMapper: (_OperationData data, _) => data.number,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            enableTooltip: true,
            explode: true,
          ),
        ]);
  }
}

class _OperationData {
  _OperationData(this.operation, this.number, [this.color]);

  final String operation;
  final double number;
  final Color? color;
}
