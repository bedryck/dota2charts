/// Simple pie chart example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class WinLoseChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  WinLoseChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory WinLoseChart.withSampleData(win, lose, animate) {
    return new WinLoseChart(
      _createSampleData(win, lose),
      // Disable animations for image tests.
      animate: animate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              insideLabelStyleSpec: new charts.TextStyleSpec(
                  fontSize: 10,
                  color: charts.ColorUtil.fromDartColor(Colors.white)),
              labelPosition: charts.ArcLabelPosition.inside)
        ]));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, String>> _createSampleData(win, lose) {
    final data = [
      new LinearSales(
          'wins', win, charts.ColorUtil.fromDartColor(Color(0xff63A375))),
      new LinearSales(
          'loses', lose, charts.ColorUtil.fromDartColor(Color(0xffD57A66))),
    ];

    return [
      new charts.Series<LinearSales, String>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.name,
        measureFn: (LinearSales sales, _) => sales.numver,
        data: data,
        labelAccessorFn: (LinearSales sales, _) => '${sales.numver}',
        colorFn: (LinearSales sales, _) => sales.color,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final String name;
  final int numver;
  final charts.Color color;

  LinearSales(this.name, this.numver, this.color);
}
