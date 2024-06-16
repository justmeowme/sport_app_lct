import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/models/course.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/form_widget.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:sport_app_lct/blocs/exercise_bloc/exercise_bloc.dart';
import 'package:sport_app_lct/repositories/exercise_repository.dart';
import 'package:sport_app_lct/widgets/custom_input_age.dart';
import '../../blocs/exercise_bloc/exercise_event.dart';
import '../../widgets/exercise_list.dart';


class CreateLesson extends StatefulWidget {
  final Course course;

  const CreateLesson({super.key, required this.course});

  @override
  CreateLessonState createState() => CreateLessonState();
}

class CreateLessonState extends State<CreateLesson> {
  final TextEditingController _durationController = TextEditingController();
  int? segmentedControlGroupValue = 0;

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
          create: (context) =>
          ExerciseBloc(exerciseRepository: ExerciseRepository())
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
                        _selectedFilter =
                        "Все";
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
                  child: ExerciseList(
                    muscle: segmentedControlGroupValue == 1 && _selectedFilter != "Все"
                      ? _selectedFilter
                      : null,
                    difficulty: segmentedControlGroupValue == 0 && _selectedFilter != "Все"
                      ? _selectedFilter
                      : null,
                  ),
                ),
                ButtonPrimary(
                  text: "Добавить",
                  onPress: () {},
                  isFullWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
