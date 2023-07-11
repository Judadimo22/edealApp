import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesData {
  final String year;
  final int dynamicValue;

  SalesData(this.year, this.dynamicValue);
}

List<charts.Series<SalesData, String>> getChartData(double montoInvertir) {
  final List<SalesData> chartData = [
    SalesData('Hoy', montoInvertir.toInt()),
    SalesData('Año 1', 0),
    SalesData('Año 2', 0),
    SalesData('Año 3', 0),
  ];

  return [
    charts.Series<SalesData, String>(
      id: 'Sales',
      data: chartData,
      domainFn: (SalesData sales, _) => sales.year,
      measureFn: (SalesData sales, _) => sales.dynamicValue,
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    ),
  ];
}

class BarChartWidget extends StatelessWidget {
  final List<charts.Series<SalesData, String>> seriesList;
  final bool animate;
  final double montoInvertir;

  BarChartWidget(this.seriesList, {required this.animate, required this.montoInvertir});

  @override
  Widget build(BuildContext context) {
    final List<charts.Series<SalesData, String>> seriesList = getChartData(montoInvertir);
    return charts.BarChart(
      seriesList,
      animate: animate,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 60, // Rotación de etiquetas del eje X
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12, // Tamaño de fuente de las etiquetas del eje Y
          ),
        ),
      ),
    );
  }
}
