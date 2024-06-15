import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/data.dart';
import '../../widgets/header.dart';

class ClientStatsScreen extends StatelessWidget {
  const ClientStatsScreen({super.key});

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
      backgroundColor: const Color(0xFF202439),
      body: Column(
        children: [
          const SizedBox(height: 56),
          Header(text: DateFormat("yMMM", 'ru').format(kToday).toString(), textColor: Colors.white),
          const SizedBox(height: 12),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      title: const ChartTitle(text: 'Динамика изменения веса'),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<Data, String>>[
                        LineSeries<Data, String>(
                          dataSource: data,
                          xValueMapper: (Data sales, _) => sales.header,
                          yValueMapper: (Data sales, _) => sales.value,
                          name: 'Вес',
                          dataLabelSettings: const DataLabelSettings(isVisible: true)
                        )
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
