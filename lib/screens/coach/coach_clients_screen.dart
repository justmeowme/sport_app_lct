import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/header.dart';

class CoachClientsScreen extends StatefulWidget {
  @override
  _CoachClientsScreenState createState() => _CoachClientsScreenState();
}

class _CoachClientsScreenState extends State<CoachClientsScreen> {
  int? segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {

    Map<int, Widget> myTabs = <int, Widget>{
      0: Padding(
        child: Text("Мои клиенты", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 18, color: segmentedControlGroupValue == 1 ? Colors.black : Colors.white),),
        padding: EdgeInsets.only(top: 12, bottom: 12),
      ),
      1: Padding(
        child: Text("Все клиенты", style: TextStyle(fontFamily: 'GilroyMedium', fontSize: 18, color: segmentedControlGroupValue == 1 ? Colors.white : Colors.black),),
        padding: EdgeInsets.only(top: 12, bottom: 12),
      ),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 24),
          child: Column(
            children: [
              Center(
                child: Header(text: "Клиенты"),
              ),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  thumbColor: Color(0xFFED6929),
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
