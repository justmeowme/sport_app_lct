import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_bloc.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_event.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_state.dart';
import 'package:sport_app_lct/widgets/course_widget.dart';

class ClientTrainsScreen extends StatefulWidget {

  const ClientTrainsScreen({super.key});

  @override
  ClientTrainsScreenState createState() => ClientTrainsScreenState();
}

class ClientTrainsScreenState extends State<ClientTrainsScreen> {
  int? segmentedControlGroupValue = 0;

  @override
  void initState() {
    super.initState();
    // Initial event dispatch
    BlocProvider.of<CoursesBloc>(context).add(LoadCourses());
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> myTabs = <int, Widget>{
      0: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 6),
        child: Text(
          "Мои курсы",
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
          "Все курсы",
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
      body: Padding(
        padding: EdgeInsets.only(top: 48, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoSlidingSegmentedControl(
                  thumbColor: const Color(0xFFED6929),
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    if (i == 1) {
                      BlocProvider.of<CoursesBloc>(context).add(LoadCourses());
                    } else {
                      BlocProvider.of<CoursesBloc>(context).add(LoadCourses());
                    }

                    setState(() {
                      segmentedControlGroupValue = i;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, coursesState) {
                  if (coursesState is CoursesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (coursesState is CoursesLoaded) {
                    if (coursesState.courses.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "assets/no_courses.png",
                          width: MediaQuery.of(context).size.width / 3 * 2,
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: coursesState.courses.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: CourseWidget(
                            course: coursesState.courses[index],
                          ),
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}