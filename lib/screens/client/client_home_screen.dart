import 'package:flutter/material.dart';

class ClientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Главная'),
      ),
      body: Center(
        child: Text('Все гуд'),
      ),
    );
  }
}
