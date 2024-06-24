import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:http/http.dart' as http;

import '../../services/auth/auth_service.dart';
import '../client/client_lesson_screen.dart';

class CourseForClient extends StatefulWidget {
  final int courseId;

  CourseForClient({super.key, required this.courseId});

  @override
  CourseForClientState createState() => CourseForClientState();
}

class CourseForClientState extends State<CourseForClient> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          child: Column(
            children: [
              Header(text: "Уроки курса id ${widget.courseId}"),

              //lesson 1
              SizedBox(height: 12,),
              GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        SmallText(text: "Урок 1. Тренируем ноги", weight: 1,),
                        Padding(padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
                          child:
                          Row(
                            children: [
                              Icon(Icons.access_alarm, color: Color(0xFFED6929),),
                              SmallText(text: "10 мин"),

                              Spacer(),

                              Icon(Icons.accessibility_outlined, color: Color(0xFFED6929),),
                              SmallText(text: "15 упражнений")
                            ],
                          ),)


                      ],
                    )
                ),
                onTap: () async {
                  final token = await AuthService().getToken();
                  final headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  };

                  String baseUrl = "http://sport-plus.sorewa.ru:8080/v1";
                  final response = await http.get(Uri.parse('$baseUrl/exercise'), headers: headers);

                  var exf = jsonDecode(response.body)["exercises"];
                  List<dynamic> exercises_selected = [exf[0], exf[1], exf[2], exf[3], exf[4], exf[5], exf[6], exf[7], exf[8], exf[9], exf[10], exf[11], exf[12], exf[13], exf[14]];

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClientLessonScreen(exercises: exercises_selected),
                    ),
                  );
                },
              ),

              //lesson 2
              SizedBox(height: 12,),
              GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        SmallText(text: "Урок 2. Тренируем руки", weight: 1,),
                        Padding(padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
                          child:
                          Row(
                            children: [
                              Icon(Icons.access_alarm, color: Color(0xFFED6929),),
                              SmallText(text: "14 мин"),

                              Spacer(),

                              Icon(Icons.accessibility_outlined, color: Color(0xFFED6929),),
                              SmallText(text: "10 упражнений")
                            ],
                          ),)


                      ],
                    )
                ),
                onTap: () async {
                  final token = await AuthService().getToken();
                  final headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  };

                  String baseUrl = "http://sport-plus.sorewa.ru:8080/v1";
                  final response = await http.get(Uri.parse('$baseUrl/exercise'), headers: headers);

                  var exf = jsonDecode(response.body)["exercises"];
                  List<dynamic> exercises_selected = [exf[15], exf[16], exf[22], exf[23], exf[24], exf[25], exf[26], exf[27], exf[30], exf[29]];

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClientLessonScreen(exercises: exercises_selected),
                    ),
                  );
                },
              ),

              //lesson 3
              SizedBox(height: 12,),
              GestureDetector(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 12,),
                        SmallText(text: "Урок 3. Тренируем ноги и руки", weight: 1,),
                        Padding(padding: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 24),
                          child:
                          Row(
                            children: [
                              Icon(Icons.access_alarm, color: Color(0xFFED6929),),
                              SmallText(text: "17 мин"),

                              Spacer(),

                              Icon(Icons.accessibility_outlined, color: Color(0xFFED6929),),
                              SmallText(text: "10 упражнений")
                            ],
                          ),)


                      ],
                    )
                ),
                onTap: () async {
                  final token = await AuthService().getToken();
                  final headers = {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer $token',
                  };

                  String baseUrl = "http://sport-plus.sorewa.ru:8080/v1";
                  final response = await http.get(Uri.parse('$baseUrl/exercise'), headers: headers);

                  var exf = jsonDecode(response.body)["exercises"];
                  List<dynamic> exercises_selected = [exf[35], exf[36], exf[37], exf[38], exf[39], exf[40], exf[41], exf[42]];

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ClientLessonScreen(exercises: exercises_selected),
                    ),
                  );
                },
              ),
            ],
          ),
          padding: EdgeInsets.only(left: 20, right: 20),
        )
      ),
    );
  }
}
