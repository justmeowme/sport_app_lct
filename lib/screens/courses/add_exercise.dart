import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_state.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/form_widget.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:sport_app_lct/repositories/exercise_repository.dart';
import 'package:sport_app_lct/widgets/custom_input_age.dart';
import '../../blocs/classes_bloc/classes_bloc.dart';
import '../../blocs/classes_bloc/classes_event.dart';
import '../../blocs/course_bloc/course_bloc.dart';
import '../../blocs/course_bloc/course_event.dart';
import '../../blocs/exercise_bloc/exercise_event.dart';
import '../../models/classes.dart';
import '../../models/exercise.dart';
import '../../repositories/course_repository.dart';
import '../../services/auth/auth_service.dart';
import '../../widgets/exercise_list.dart';
import '../../blocs/exercise_bloc/exercise_state.dart';

class AddExercise extends StatefulWidget {
  final int courseId;

  AddExercise({super.key, required this.courseId});

  @override
  AddExerciseState createState() => AddExerciseState();
}

class AddExerciseState extends State<AddExercise> {
  final TextEditingController _durationController = TextEditingController();
  int? segmentedControlGroupValue = 0;
  Exercise? _selectedExercise;
  final CourseRepository _courseRepository = CourseRepository();
  late Future<Course> _courseFuture;

  //p.s здесь курс по айди получается без блока
  //3 часа фиксила ошибку с null is not subtype of int и задолбалась


  Future<void> updateCourse(int courseId, Course course, String baseUrl) async {
    final token = await AuthService().getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.put(
      Uri.parse('$baseUrl/v1/course/$courseId'),
      headers: headers,
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update course');
    }
  }

  @override
  void initState() {
    super.initState();
    _courseFuture = _courseRepository.getCourseById(widget.courseId);
  }

  List<Map<String, dynamic>> musclesCategories = [
    {"text": "Все", "icon": Icons.abc},
    {"text": "Пресс", "icon": Icons.abc},
    {"text": "Нижняя часть спины", "icon": Icons.abc},
    {"text": "Трицепцы", "icon": Icons.abc},
    {"text": "Плечи", "icon": Icons.abc},
    {"text": "Широчайшие мышцы спины", "icon": Icons.abc},
    {"text": "Квадрицепсы", "icon": Icons.abc},
    {"text": "Грудь", "icon": Icons.abc},
    {"text": "Бедра", "icon": Icons.abc},
    {"text": "Средняя часть спины", "icon": Icons.abc},
    {"text": "Бицепс", "icon": Icons.abc},
    {"text": "Икры", "icon": Icons.abc},
    {"text": "Ягодицы", "icon": Icons.abc},
    {"text": "Аддукторы", "icon": Icons.abc},
    {"text": "Шея", "icon": Icons.abc},
    {"text": "Предплечья", "icon": Icons.abc},
    {"text": "Абдукторы", "icon": Icons.abc},
  ];

  List<Map<String, dynamic>> difficultyCategories = [
    {"text": "Все", "icon": Icons.abc},
    {"text": "Начинающий", "icon": Icons.abc},
    {"text": "Средний", "icon": Icons.abc},
    {"text": "Профессионал", "icon": Icons.abc},
  ];

  String _selectedFilter = "Все";

  @override
  Widget build(BuildContext context) {
    context.read<CoursesBloc>().add(LoadCourseById(widget.courseId));

    Map<int, Widget> myTabs = <int, Widget>{
      0: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Text(
          "По сложности",
          style: TextStyle(
            fontFamily: 'GilroyMedium',
            fontSize: 18,
            color: segmentedControlGroupValue == 1 ? Colors.black : Colors.white,
          ),
        ),
      ),
      1: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Text(
          "По мышцам",
          style: TextStyle(
            fontFamily: 'GilroyMedium',
            fontSize: 18,
            color: segmentedControlGroupValue == 1 ? Colors.white : Colors.black,
          ),
        ),
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ExerciseBloc(exerciseRepository: ExerciseRepository())
            ..add(LoadExercisesEvent()),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset("assets/back_button.png", height: 32),
                    ),
                    const Spacer(),
                    Header(
                      text: "Упражнения",
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(width: 32),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 16),
                CustomInputAge(
                  controller: _durationController,
                  isDescription: true,
                  description: "Длительность упражнения (в секундах)",
                ),
                const SizedBox(height: 16),
                SmallText(text: "Список упражнений"),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoSlidingSegmentedControl(
                    thumbColor: const Color(0xFFED6929),
                    groupValue: segmentedControlGroupValue,
                    children: myTabs,
                    onValueChanged: (i) {
                      setState(() {
                        segmentedControlGroupValue = i;
                        _selectedFilter = "Все";
                      });
                    },
                  ),
                ),
                const SizedBox(height: 4,),
                FormWidget(
                  isMultiSelect: false,
                  isHorizontal: true,
                  items: segmentedControlGroupValue == 0
                      ? difficultyCategories
                      : musclesCategories,
                  onItemSelected: (index) {
                    setState(() {
                      _selectedFilter = segmentedControlGroupValue == 0
                          ? difficultyCategories[index]["text"]
                          : musclesCategories[index]["text"];
                    });
                  },
                  forFilter: true,
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
                    if (state is ExerciseLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ExerciseLoadedState) {
                      return ExerciseList(
                        exercises: state.exercises,
                        muscle: segmentedControlGroupValue == 1 && _selectedFilter != "Все"
                            ? _selectedFilter
                            : null,
                        difficulty: segmentedControlGroupValue == 0 && _selectedFilter != "Все"
                            ? _selectedFilter
                            : null,
                        onExerciseSelected: (exercise) {
                          setState(() {
                            _selectedExercise = exercise;
                            print(_selectedExercise?.name);
                            print("SELECTED EXERCISE");
                          });
                        },
                      );
                    } else if (state is ExerciseErrorState) {
                      return Center(child: Text('Error: ${state.message}'));
                    } else {
                      return Center(child: Text('Упражнений не найдено'));
                    }
                  }),
                ),

                ButtonPrimary(
                  text: "Добавить",
                  isFullWidth: true,
                  onPress: () async {
                    final token = await AuthService().getToken();
                    final headers = {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $token',
                    };

                    String baseUrl = "http://sport-plus.sorewa.ru:8080/v1";
                    final response = await http.get(Uri.parse('$baseUrl/course/${widget.courseId}'), headers: headers);

                    if (response.statusCode == 200) {
                      final responseJson = jsonDecode(response.body);
                      final crus = responseJson["course"];

                      print("HERE FIRST RESPONSE");
                      print(responseJson);

                      List<Map<String, dynamic>> classes = [];

                      for (dynamic cls in crus["classes"]) {
                        List<Map<String, dynamic>> lessons = [];
                        for (dynamic lesson in cls["lessons"]) {
                          List<Map<String, dynamic>> exercises = [];
                          for (dynamic exrs in lesson["exercises"]){
                            exercises.add({
                              "exercise": {
                                "muscle": exrs["exercise"]["muscle"],
                                "name": exrs["exercise"]["name"],
                                "duration": exrs["exercise"]["duration"],
                                "photos": exrs["exercise"]["photos"],
                              },
                              "exercise_id": exrs["exercise"]["id"],
                              "id": exrs["id"],
                              "lesson_id": exrs["lesson_id"]
                            });
                          }
                          lessons.add({
                            "class_id": lesson["class_id"],
                            "course_id": lesson["course_id"],
                            "created_at": lesson["created_at"],
                            "duration_seconds": lesson["duration_seconds"],
                            "exercises": exercises,
                            "id": lesson["id"],
                            "updated_at": lesson["updated_at"]
                          });
                        }
                        classes.add({
                          "course_id": cls["course_id"],
                          "cover": cls["cover"],
                          "created_at": cls["created_at"],
                          "description": cls["description"],
                          "id": cls["id"],
                          "lessons": lessons,
                          "title": cls["title"],
                          "updated_at": cls["updated_at"]
                        });
                      }

                      print("HERE CLASSES");
                      print(classes);

                      if (classes.isNotEmpty && classes.last["lessons"].isEmpty) {
                        classes.last["lessons"] = [
                          {
                            "class_id": classes.last["id"],
                            "course_id": widget.courseId,
                            "created_at": DateTime.now().toIso8601String(),
                            "duration_seconds": 0,
                            "exercises": [
                              {
                                "exercise": {
                                  "muscle": _selectedExercise!.muscle,
                                  "name": _selectedExercise!.name,
                                  "duration": _selectedExercise!.duration,
                                  "photos": _selectedExercise!.photos,
                                },
                                "exercise_id": _selectedExercise!.id,
                                "id": 0,
                                "lesson_id": 0
                              }
                            ],
                            "id": 0,
                            "updated_at": DateTime.now().toIso8601String()
                          }
                        ];
                      } else {
                        classes.last["lessons"].last["exercises"].add({
                          "exercise": {
                            "muscle": _selectedExercise!.muscle,
                            "name": _selectedExercise!.name,
                            "duration": _selectedExercise!.duration,
                            "photos": _selectedExercise!.photos,
                          },
                          "exercise_id": _selectedExercise!.id,
                          "id": 0,
                          "lesson_id": 0
                        });
                      }

                      print("HERE UPDATED CLS");
                      print(classes);

                      final updatedCourse = {
                        "course": {
                          "classes": classes,
                          "cost": crus["cost"],
                          "created_at": crus["created_at"],
                          "description": crus["description"],
                          "difficulty": crus["difficulty"],
                          "difficulty_numeric": crus["difficulty_numeric"],
                          "direction": crus["direction"],
                          "id": crus["id"],
                          "participants_count": crus["participants_count"],
                          "rating": crus["rating"],
                          "required_tools": crus["required_tools"],
                          "title": crus["title"],
                          "trainer_id": crus["trainer_id"],
                          "updated_at": crus["updated_at"]
                        }
                      };

                      print("HERE UPDATED COURSE");
                      print(updatedCourse);

                      print("HEREE IS URL");
                      print('$baseUrl/course/${widget.courseId}');

                      final response1 = await http.put(
                        Uri.parse('$baseUrl/course/${widget.courseId}'),
                        headers: headers,
                        body: jsonEncode(updatedCourse),
                      );

                      print("HERE IS RESPONSE");
                      print(jsonDecode(response1.body)["course"]["classes"]);

                      if (response1.statusCode != 200) {
                        throw Exception('Failed to update course');
                      }
                    } else {
                      throw Exception('Failed to load course');
                    }
                  },
                )

                // FutureBuilder<Course>(
                //   future: _courseFuture,
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else if (snapshot.hasError) {
                //       return Center(child: Text('Error: ${snapshot.error}'));
                //     } else if (snapshot.hasData) {
                //       Course currentCourse = snapshot.data!;
                //       return ButtonPrimary(
                //         text: "Добавить",
                //         onPress: () async {
                //           if (_selectedExercise != null) {
                //             if (_durationController.text.isEmpty) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(content: Text('Пожалуйста, введите длительность упражнения')),
                //               );
                //               return;
                //             }
                //
                //             try {
                //               int duration = int.parse(_durationController.text.trim());
                //
                //               print(currentCourse.toJson());
                //               print('HERE IS COIOOOOOORUSE');
                //             } catch (e) {
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(content: Text('Некорректное значение длительности')),
                //               );
                //             }
                //           } else {
                //             ScaffoldMessenger.of(context).showSnackBar(
                //               SnackBar(content: Text('Пожалуйста, выберите упражнение')),
                //             );
                //           }
                //         },
                //         isFullWidth: true,
                //       );
                //     } else {
                //       return Container();
                //     }
                //   },
                // )


              ],
            ),
          ),
        ),
      ),
    );
  }
}
