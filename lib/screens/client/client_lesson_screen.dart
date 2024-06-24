import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_lct/screens/client/client_home_screen.dart';
import 'package:sport_app_lct/screens/client/client_sport_screen.dart';
import 'package:sport_app_lct/screens/courses/%D1%81ourse_for_client.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import 'package:sport_app_lct/widgets/header.dart';
import 'package:sport_app_lct/widgets/small_text.dart';
import 'dart:async';

import '../courses/courses_list.dart';

class ClientLessonScreen extends StatefulWidget {
  final List<dynamic> exercises;

  ClientLessonScreen({super.key, required this.exercises});

  @override
  ClientLessonScreenState createState() => ClientLessonScreenState();
}

class ClientLessonScreenState extends State<ClientLessonScreen> {
  int _currentExerciseIndex = 0;
  int _currentPhotoIndex = 0;
  Timer? _exerciseTimer;
  Timer? _photoTimer;
  Duration _exerciseDuration = Duration(minutes: 1);
  Duration _remainingTime = Duration(minutes: 1);

  @override
  void initState() {
    super.initState();
    _startExerciseTimer();
    _startPhotoTimer();
  }

  @override
  void dispose() {
    _exerciseTimer?.cancel();
    _photoTimer?.cancel();
    super.dispose();
  }

  void _startExerciseTimer() {
    _exerciseTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds == 0) {
        _nextExercise();
      } else {
        setState(() {
          _remainingTime -= Duration(seconds: 1);
        });
      }
    });
  }

  void _startPhotoTimer() {
    _photoTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        List<dynamic> lst = widget.exercises[_currentExerciseIndex]["photos"];
        _currentPhotoIndex = (_currentPhotoIndex + 1) % lst.length;
      });
    });
  }

  void _nextExercise() {
    _exerciseTimer?.cancel();
    _photoTimer?.cancel();
    if (_currentExerciseIndex < widget.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _currentPhotoIndex = 0;
        _remainingTime = _exerciseDuration;
      });
      _startExerciseTimer();
      _startPhotoTimer();
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ClientHomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(text: "Урок 1"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(
                    weight: 1,
                    text: "${_currentExerciseIndex + 1}/${widget.exercises.length}",
                  ),
                  SmallText(
                    weight: 1,
                    text: "${_remainingTime.inMinutes.toString().padLeft(2, '0')}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}",
                    textColor: Color(0xFFED6929),
                  ),
                ],
              ),
              SizedBox(height: 20),

              SmallText(text: widget.exercises[_currentExerciseIndex]["name"]),
              SizedBox(height: 20),

              Image.network(widget.exercises[_currentExerciseIndex]["photos"][_currentPhotoIndex]["url"]),
              SizedBox(height: 20),

              Spacer(),

              ButtonPrimary(text: "Далее", onPress: _nextExercise, isFullWidth: true,),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
