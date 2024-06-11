import 'package:flutter/material.dart';

class HeightSlider extends StatefulWidget {
  final int minHeight;
  final int maxHeight;
  final int initialHeight;
  final ValueChanged<int> onHeightChanged;

  const HeightSlider({
    Key? key,
    this.minHeight = 50,
    this.maxHeight = 250,
    this.initialHeight = 170,
    required this.onHeightChanged,
  }) : super(key: key);

  @override
  _HeightSliderState createState() => _HeightSliderState();
}

class _HeightSliderState extends State<HeightSlider> {
  late int _currentHeight;

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.initialHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        Text(
          '${_currentHeight.toInt()} см',
          style: TextStyle(
            fontFamily: 'GilroyMedium',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFED6929)
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(0xFFED6929),
            inactiveTrackColor: Color(0xFFED6929).withOpacity(0.3),
            trackHeight: 8.0,
            thumbColor: Color(0xFFED6929),
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            overlayColor: Color(0xFFED6929).withOpacity(0.2),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 24.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Color(0xFFED6929),
            inactiveTickMarkColor: Color(0xFFED6929).withOpacity(0.3),
          ),
          child: Slider(
            value: _currentHeight.toDouble(),
            min: widget.minHeight.toDouble(),
            max: widget.maxHeight.toDouble(),
            divisions: (widget.maxHeight - widget.minHeight).toInt(),
            onChanged: (double value) {
              setState(() {
                _currentHeight = value.toInt();
                widget.onHeightChanged(_currentHeight);
              });
            },
          ),
        ),
      ],
    );
  }
}
