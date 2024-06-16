import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/models/user.dart';
import 'package:sport_app_lct/screens/client/client_nutrition_screen.dart';
import 'package:sport_app_lct/widgets/client_info_component.dart';
import 'package:sport_app_lct/widgets/custom_input.dart';
import '../../blocs/user_bloc/user_event.dart';
import '../../services/auth/auth_service.dart';
import '../../widgets/header.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_state.dart';

class ClientBodyScreen extends StatelessWidget {
  const ClientBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kToday = DateTime.now();



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
                topLeft: Radius.circular(32),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserLoadingState) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is UserLoadedState) {
                          final user = state.user;
                          print('User: ${jsonEncode(user)}');
                          return Row(
                            children: [
                              Image.asset(user.gender == "Female" ? "assets/woman_siluet.png" : "assets/man_siluet.png", height: 450),
                              const Spacer(),
                              Column(
                                children: [
                                  ClientInfoComponent(
                                    header: "За неделю",
                                    withPlus: false,
                                    value: "0",
                                    value_description: "тренировок",
                                    onPress: () {
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  ClientInfoComponent(
                                    header: "Вес",
                                    value: user.weight?.last["value"] ?? 0,
                                    value_description: "кг",
                                    onPress: () {
                                      _showWeightInputDialog(context, user);
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  ClientInfoComponent(
                                    header: "Калории",
                                    value: "0",
                                    value_description: "ккал",
                                    onPress: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const ClientNutritionScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  ClientInfoComponent(
                                    header: "Вода",
                                    value: "0",
                                    value_description: "стаканов",
                                    onPress: () {

                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        } else if (state is UserErrorState) {
                          return Center(child: Text('Ошибка: ${state.message}'));
                        } else {
                          return const Center(child: Text('Нет данных'));
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset("assets/connect_watch.png", width: MediaQuery.of(context).size.width),
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeightInputDialog(BuildContext context, User user) {
    TextEditingController weightController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
              "Введите новый вес",
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'GilroyMedium'
            ),
          ),
          content: SizedBox(height: 72, child: CustomInput(controller: weightController,),),
          actions: <Widget>[
            TextButton(
              child: Text("Отмена", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 16, color: Color(0xFFED6929)),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Сохранить", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 16, color: Color(0xFFED6929)),),
              onPressed: () async {

                final token = await AuthService().getToken();
                final headers = {
                  'Authorization': 'Bearer $token',
                };

                String newWeight = weightController.text;
                String baseUrl = "http://sport-plus.sorewa.ru:8080/v1";

                final response = await http.post(
                  Uri.parse("$baseUrl/user/measurements"),
                  headers: headers,
                  body: jsonEncode({
                    "date": DateTime.now().toString(),
                    "value": newWeight.toString().trim(),
                    "type": "weight",
                  })
                );

                print(response.body);

                context.read<UserBloc>().add(UpdateUserEvent(user: user));

                Navigator.of(context).pop();

              }
            ),
          ],
        );
      },
    );
  }
}
