import 'package:flutter/material.dart';
import 'package:gym/domain/models/sales.dart';
import 'package:gym/ui/utils/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';



class ChartPage extends StatefulWidget {
  final Grafica grafica;
  ChartPage({Key? key, required this.grafica}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChartPage> {

  @override
  Widget build(BuildContext context) {
    return Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: widget.grafica.nombre, textStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'NeoRegular',
                            fontWeight: FontWeight.w700)),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<SalesData, String>>[
                LineSeries<SalesData, String>(
                  color: primary,
                    dataSource: widget.grafica.listSales,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    name: '',
                    isVisibleInLegend: false,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: false))
              ]),
              const SizedBox(height: 16,)
        
        ]);
  }
}

