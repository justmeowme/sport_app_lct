import 'package:flutter/material.dart';
import 'package:sport_app_lct/widgets/description.dart';
import 'package:sport_app_lct/widgets/small_text.dart';

class SelectableItem extends StatefulWidget {
  final IconData? icon;
  final String text;
  final bool isActive;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;
  final double inactiveOpacity;

  const SelectableItem({
    Key? key,
    this.icon,
    required this.text,
    required this.isActive,
    required this.onTap,
    this.activeColor = const Color(0xFFED6929),
    this.inactiveColor = const Color(0xFFED6929),
    this.inactiveOpacity = 0.2,
  }) : super(key: key);

  @override
  _SelectableItemState createState() => _SelectableItemState();
}

class _SelectableItemState extends State<SelectableItem> {
  @override
  Widget build(BuildContext context) {
    Color borderColor = widget.isActive ? widget.activeColor : widget.inactiveColor.withOpacity(widget.inactiveOpacity);
    Color iconColor = widget.isActive ? widget.activeColor : widget.inactiveColor.withOpacity(widget.inactiveOpacity);
    Color textColor = widget.isActive ? widget.activeColor : widget.inactiveColor.withOpacity(widget.inactiveOpacity);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 3),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon == null)
              Center(
                child: SmallText(text: widget.text, textColor: textColor,),
              ),

            if (widget.icon != null)
              Row(
                children: [
                  Icon(widget.icon, color: iconColor),
                  SizedBox(width: 8),
                  SmallText(text: widget.text, textColor: textColor,)
                ],
              ),
          ],
        ),
      ),
    );
  }
}
