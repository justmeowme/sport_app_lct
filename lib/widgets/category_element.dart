import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/description.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

class CategoryElement extends StatefulWidget {
  final String text;
  final bool isActive;
  final VoidCallback onTap;

  const CategoryElement({
    Key? key,
    required this.text,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  _CategoryElementState createState() => _CategoryElementState();
}

class _CategoryElementState extends State<CategoryElement> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = widget.isActive ? Color(0xFFED6929) : Color(0xFFED6929).withOpacity(0.3);
    Color textColor = widget.isActive ? Color(0xFFED6929) : Color(0xFFED6929).withOpacity(0.3);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: SmallText(text: widget.text, textColor: textColor,),
      ),
    );
  }
}
