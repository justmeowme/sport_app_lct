import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/header.dart';

class CoachClientsScreen extends StatefulWidget {
  const CoachClientsScreen({super.key});

  @override
  CoachClientsScreenState createState() => CoachClientsScreenState();
}

class CoachClientsScreenState extends State<CoachClientsScreen> {
  int? segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {

    Map<int, Widget> myTabs = <int, Widget>{
      0: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text("Мои клиенты", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 18, color: segmentedControlGroupValue == 1 ? Colors.black : Colors.white),),
      ),
      1: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        child: Text("Все клиенты", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 18, color: segmentedControlGroupValue == 1 ? Colors.white : Colors.black),),
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
          child: Column(
            children: [
              Center(
                child: Header(text: "Клиенты"),
              ),
              const SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  thumbColor: const Color(0xFFED6929),
                  groupValue: segmentedControlGroupValue,
                  children: myTabs,
                  onValueChanged: (i) {
                    setState(() {
                      segmentedControlGroupValue = i;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
