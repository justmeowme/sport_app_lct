import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_app_lct/repositories/user_repository.dart';

import '../models/shedule.dart';
import '../models/user.dart';

class ScheduleWidget extends StatefulWidget {
  final Shedule schedule;
  final String forWho;

  const ScheduleWidget({
    Key? key,
    required this.schedule,
    required this.forWho,
  }) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  bool isReminderEnabled = false;

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    DateTime dateTime = DateTime.parse(widget.schedule.startTime);
    String startTimeFormatted = DateFormat('HH:mm').format(dateTime);
    final displayUser = widget.forWho == 'client' ? widget.schedule.coach : widget.schedule.client;
    final displayText = "Тренировка с " + (displayUser != null ? displayUser.login : '');

    return GestureDetector(
      onTap: () => _toggleReminder(context),
      child: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
          decoration: BoxDecoration(
            color: Color(0xFFD6D8DB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Text(
                  startTimeFormatted,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'GilroyMedium',
                    fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(width: 16),
              Expanded(child: Text(displayText, style: TextStyle(fontSize: 18))),
              SizedBox(width: 16),
              Icon(
                isReminderEnabled ? Icons.notifications : Icons.notifications_off,
                color: isReminderEnabled ? Color(0xFFED6929) : Color(0x50ED6929),
              ),
            ],
          ),
        ),
      )
    );
  }

  void _toggleReminder(BuildContext context) {
    final action = isReminderEnabled ? 'отключить' : 'включить';
    final reminderStatus = isReminderEnabled ? 'отключены' : 'включены';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Хотите $action уведомления для "${widget.schedule.type}"?'),
          content: Text('Мы напомним о мероприятии за 15 минут.'),
          actions: [
            TextButton(
              child: Text('Нет'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Да'),
              onPressed: () {
                setState(() {
                  isReminderEnabled = !isReminderEnabled;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Уведомления $reminderStatus.')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}