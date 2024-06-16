import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_bloc.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_event.dart';
import 'package:sport_app_lct/blocs/course_bloc/course_state.dart';
import 'package:sport_app_lct/screens/courses/create_course.dart';
import 'package:sport_app_lct/widgets/button_primary.dart';
import '../../widgets/course_widget.dart';
import '../../widgets/header.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CoursesBloc>(context).add(LoadCourses());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 48, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Image.asset("assets/back_button.png", height: 44, width: 44,),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                Center(
                  child: Header(text: "Ваши курсы",),
                ),
                const Spacer(),
              ],
            ),
            Expanded(
              child: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, coursesState) {
                  if (coursesState is CoursesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (coursesState is CoursesLoaded) {
                    if (coursesState.courses.isEmpty) {
                      return Center(
                        child: Image.asset("assets/no_courses.png", width: MediaQuery.of(context).size.width / 3 * 2,),
                      );
                    }
                    return ListView.builder(
                      itemCount: coursesState.courses.length,
                      itemBuilder: (context, index) {
                        return CourseWidget(
                          course: coursesState.courses[index],
                        );
                      },
                    );
                  }

                  return Container();
                },
              ),
            ),
            ButtonPrimary(
              text: "Создать курс",
              onPress: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateCourse(),
                  ),
                );
              },
              isFullWidth: true,
            ),
            const SizedBox(height: 20,)
          ],
        ),
      )
    );
  }
}
