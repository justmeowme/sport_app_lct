import 'package:flutter/material.dart';

class ClientInfoComponent extends StatelessWidget {
  final String header;
  final String value;
  final String value_description;

  final VoidCallback onPress;

  ClientInfoComponent({required this.header, required this.value, required this.value_description, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEFF0F1),
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      width: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: 'GilroyMedium',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'GilroyMedium',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFED6929)
                  ),
                ),
                Text(
                  value_description,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'GilroyMedium',
                      color: Color(0xFFEEAC8D)
                  ),
                )
              ],
            ),
            Spacer(),
            Image.asset("assets/plus.png", height: 24,),
          ],
        )
      )
    );
  }
}
