// client_main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../models/data.dart';
import '../../widgets/header.dart';

class ClientStatsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();

    List<Data> data = [
      Data(header: '12 May', value: 57),
      Data(header: '16 May', value: 59),
      Data(header: '12 Jun', value: 55),
      Data(header: '28 Jun', value: 52),
    ];


    return Scaffold(
      backgroundColor: Color(0xFF202439),
      body: Column(
        children: [
          SizedBox(height: 56),
          Header(text: DateFormat("yMMM", 'ru').format(kToday).toString(), textColor: Colors.white),
          SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      title: ChartTitle(text: 'Динамика изменения веса'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<Data, String>>[
                        LineSeries<Data, String>(
                            dataSource: data,
                            xValueMapper: (Data sales, _) => sales.header,
                            yValueMapper: (Data sales, _) => sales.value,
                            name: 'Вес',
                            dataLabelSettings: DataLabelSettings(isVisible: true))
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
