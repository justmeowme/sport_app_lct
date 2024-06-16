import 'package:flutter/material.dart';

class ClientInfoComponent extends StatelessWidget {
  final String header;
  final String value;
  final String value_description;
  final bool withPlus;

  final VoidCallback onPress;

  ClientInfoComponent({required this.header, required this.value, required this.value_description, required this.onPress, this.withPlus = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEFF0F1),
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
      width: 160,
      height: 100,
      child: Padding(
        padding: EdgeInsets.only(left: 32, right: 12, top: 4, bottom: 4),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: TextStyle(
                    fontSize: 16,
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
            GestureDetector(
              onTap: onPress,
              child: Opacity(
                child: Image.asset("assets/plus.png", height: 24,),
                opacity: withPlus == false ? 0.0 : 1.0,
              ),
            )
          ],
        )
      )
    );
  }
}
