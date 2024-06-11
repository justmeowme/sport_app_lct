import 'package:flutter/cupertino.dart';
import 'package:sport_app_lct/widgets/selectable_item.dart';

class FormWidget extends StatefulWidget {
  final bool isMultiSelect;
  final bool isHorizontal;
  final List<Map<String, dynamic>> items;
  final Function(int) onItemSelected;

  const FormWidget({
    Key? key,
    required this.isMultiSelect,
    required this.isHorizontal,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  List<int> selectedIndexes = [0];

  void onItemTapped(int index) {
    setState(() {
      if (widget.isMultiSelect) {
        if (selectedIndexes.contains(index)) {
          selectedIndexes.remove(index);
        } else {
          selectedIndexes.add(index);
        }
      } else {
        if (selectedIndexes.contains(index)) {
          selectedIndexes.clear();
        } else {
          selectedIndexes = [index];
        }
      }
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isHorizontal
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.items.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;

        // Определение отступов для крайних элементов
        EdgeInsetsGeometry padding;
        if (index == 0) {
          padding = const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0); // Первый элемент, без отступа слева
        } else if (index == widget.items.length - 1) {
          padding = const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0); // Последний элемент, без отступа справа
        } else {
          padding = const EdgeInsets.all(8.0); // Все остальные элементы
        }

        return Expanded(
          child: Padding(
            padding: padding,
            child: SelectableItem(
              icon: item['icon'],
              text: item['text'],
              isActive: selectedIndexes.contains(index),
              onTap: () => onItemTapped(index),
            ),
          ),
        );
      }).toList(),
    )
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.items.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SelectableItem(
            icon: item['icon'],
            text: item['text'],
            isActive: selectedIndexes.contains(index),
            onTap: () => onItemTapped(index),
          ),
        );
      }).toList(),
    );
  }
}

