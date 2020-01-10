import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../helpers/helpers.dart';

class HorizontalBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final List<HorizontalModel> data;
  final bool mode;

  HorizontalBarChart(
    this.seriesList,
    this.data, {
    this.animate,
    this.mode,
  });

  /// Creates a [BarChart] with sample data and no transition.
  factory HorizontalBarChart.withSampleData(data, mode) {
    return new HorizontalBarChart(
      _createSampleData(data, mode),
      data,
      mode: mode,
      // Disable animations for image tests.
      animate: false,
    );
  }

  // [BarLabelDecorator] will automatically position the label
  // inside the bar if the label will fit. If the label will not fit and the
  // area outside of the bar is larger than the bar, it will draw outside of the
  // bar. Labels can always display inside or outside using [LabelPosition].
  //
  // Text style for inside / outside can be controlled independently by setting
  // [insideLabelStyleSpec] and [outsideLabelStyleSpec].
  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
      // Set a bar label decorator.
      // Example configuring different styles for inside/outside:
      //       barRendererDecorator: new charts.BarLabelDecorator(
      //          insideLabelStyleSpec: new charts.TextStyleSpec(...),
      //          outsideLabelStyleSpec: new charts.TextStyleSpec(...)),
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  color: mode
                      ? charts.Color.fromHex(code: '#03dac6')
                      : charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: mode
                      ? charts.Color.fromHex(code: '#03dac6')
                      : charts.MaterialPalette.black))),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<HorizontalModel, String>> _createSampleData(
      data, mode) {
    return [
      new charts.Series<HorizontalModel, String>(
        id: 'Sales',
        domainFn: (HorizontalModel sales, _) => sales.mode,
        measureFn: (HorizontalModel sales, _) => sales.games,
        data: data,
        // Set a label accessor to control the text of the bar label.
        labelAccessorFn: (HorizontalModel sales, _) =>
            '${sales.games} games - ${proz(sales.games, sales.win)}% winrate',
        outsideLabelStyleAccessorFn: (HorizontalModel sales, _) {
          final color = mode
              ? charts.MaterialPalette.white
              : charts.MaterialPalette.black;
          return new charts.TextStyleSpec(color: color);
        },
        // insideLabelStyleAccessorFn: (HorizontalModel sales, _) {
        //   final color = charts.MaterialPalette.white;
        //   return new charts.TextStyleSpec(color: color);
        // },
      )
    ];
  }
}

/// Sample ordinal data type.
class HorizontalModel {
  final String mode;
  final int games;
  final int win;

  HorizontalModel(this.mode, this.games, this.win);
}
