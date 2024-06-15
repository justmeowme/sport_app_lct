import 'package:flutter/material.dart';
import 'package:sport_app_lct/models/exercise.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'package:sport_app_lct/widgets/tag.dart';

class ExerciseWidget extends StatelessWidget {
  final Exercise exercise;
  final bool selected;

  ExerciseWidget({required this.exercise, required this.selected});

  @override
  Widget build(BuildContext context) {

    List<String> muscles = exercise.muscle.split(",");
    int musclesLength = exercise.muscle.length;
    int difficulty = exercise.difficulty == "Профессионал" ? 3 : exercise.difficulty == "Средний" ? 2 : 1;

    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: selected == true ?
          Border.all(
            color: Color(0xFFED6929),
            width: 4,
          ) : null,
          color: Color(0xFFEFF0F1),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Padding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (musclesLength < 24)
                Row(
                  children: muscles.map((muscle) => Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Tag(text: muscle, color: Color(0xFFEE672A)),
                  )).toList(),
                ),

              if (musclesLength >= 24)
                Column(
                  children: [
                    Row(
                      children: muscles.getRange(0, 2).map((muscle) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Tag(text: muscle, color: Color(0xFFEE672A)),
                      )).toList(),
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: muscles.getRange(2, muscles.length).map((muscle) => Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Tag(text: muscle, color: Color(0xFFEE672A)),
                      )).toList(),
                    ),
                  ],
                ),

              SizedBox(height: 16,),

              Text(
                exercise.name,
                style: TextStyle(
                    fontFamily: 'GilroyMedium',
                    fontWeight: FontWeight.bold,
                    fontSize: 24
                ),
              ),

              SizedBox(height: 12,),

              Row(
                children: [
                  Image.asset("assets/difficulty${difficulty}_red.png", height: 20),
                  SizedBox(width: 12,),
                  SmallText(
                      text: exercise.difficulty
                  ),
                ],
              )

            ],
          ),
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 12, right: 12),
        )
    );
  }
}
