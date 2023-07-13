import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesData {
  final int year;
  final int dynamicValue;

  SalesData(this.year, this.dynamicValue);
}

List<charts.Series<dynamic, num>> getChartData(double montoInvertir) {
  final List<SalesData> chartData = [
    SalesData(0, montoInvertir.toInt()),
    SalesData(1, ((montoInvertir * 0.06) + montoInvertir).toInt()),
    SalesData(
        2,
        (((montoInvertir * 0.06) + montoInvertir) + montoInvertir * 0.06)
            .toInt()),
    SalesData(
        3,
        (((montoInvertir * 0.06) + montoInvertir) + montoInvertir * 0.06)
            .toInt()),
  ];

  final List<charts.Series<dynamic, num>> seriesList = [
    charts.Series<SalesData, num>(
      id: 'Saldo de la cuenta',
      data: chartData,
      domainFn: (SalesData sales, _) => sales.year,
      measureFn: (SalesData sales, _) => sales.dynamicValue,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    ),
  ];

  return seriesList.cast<charts.Series<dynamic, num>>();
}

class LineChartWidget extends StatelessWidget {
  final List<charts.Series<dynamic, num>> seriesList;
  final bool animate;
  final double montoInvertir;

  LineChartWidget(this.seriesList, {required this.animate, required this.montoInvertir});

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<dynamic, num>> seriesList =
        getChartData(montoInvertir);
    return charts.LineChart(
      seriesList,
      animate: animate,
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          desiredMaxRows: 2,
        ),
        charts.ChartTitle('Año',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('Value',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
      defaultRenderer: charts.LineRendererConfig(
        includePoints: true,
        radiusPx: 5.0,
      ),
    );
  }
}

