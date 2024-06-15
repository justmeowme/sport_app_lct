// client_main_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/screens/client/client_stats_screen.dart';
import 'package:sport_app_lct/widgets/client_info_component.dart';
import '../../widgets/header.dart';

class ClientBodyScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();

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
                topLeft: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    Row(
                      children: [
                        Image.asset("assets/man_siluet.png", height: 450),
                        Spacer(),
                        Column(
                          children: [
                            ClientInfoComponent(
                              header: "За неделю",
                              value: "12",
                              value_description: "тренировок",
                              onPress: () {},
                            ),
                            SizedBox(height: 12),
                            ClientInfoComponent(
                              header: "Вес",
                              value: "72",
                              value_description: "кг",
                              onPress: () {},
                            ),
                            SizedBox(height: 12),
                            ClientInfoComponent(
                              header: "Калории",
                              value: "260",
                              value_description: "ккал",
                              onPress: () {},
                            ),
                            SizedBox(height: 12),
                            ClientInfoComponent(
                              header: "Вода",
                              value: "4",
                              value_description: "стакана",
                              onPress: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/connect_watch.png", width: MediaQuery.of(context).size.width),
                    ),
                    SizedBox(height: 64),
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
