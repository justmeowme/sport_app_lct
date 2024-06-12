import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TrainingTextContainer extends StatelessWidget {
  final DateTime selectedDay;
  final DateTime kToday;

  TrainingTextContainer({
    required this.selectedDay,
    required this.kToday,
  });

  String getTrainingText(DateTime selectedDay, DateTime kToday) {
    if (isSameDay(selectedDay, kToday)) {
      return "На сегодня нет тренировок";
    } else if (isSameDay(selectedDay, kToday.add(Duration(days: 1)))) {
      return "На завтра нет тренировок";
    } else {
      return "На это число нет тренировок";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Color(0xFFEEEEEE)
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                getTrainingText(selectedDay, kToday),
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'GilroyMedium',
                    color: Color(0xFF5C5F6E)
                )
            )
          ],
        ),
      ),
    );
  }
}