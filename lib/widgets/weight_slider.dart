import 'package:flutter/material.dart';

class WeightSlider extends StatefulWidget {
  final int minWeight;
  final int maxWeight;
  final int initialWeight;
  final ValueChanged<int> onWeightChanged;

  const WeightSlider({
    Key? key,
    this.minWeight = 40,
    this.maxWeight = 150,
    this.initialWeight = 50,
    required this.onWeightChanged,
  }) : super(key: key);

  @override
  _WeightSliderState createState() => _WeightSliderState();
}

class _WeightSliderState extends State<WeightSlider> {
  late int _currentWeight;

  @override
  void initState() {
    super.initState();
    _currentWeight = widget.initialWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        Text(
          '${_currentWeight.toInt()} кг',
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
            value: _currentWeight.toDouble(),
            min: widget.minWeight.toDouble(),
            max: widget.maxWeight.toDouble(),
            divisions: (widget.maxWeight - widget.minWeight).toInt(),
            onChanged: (double value) {
              setState(() {
                _currentWeight = value.toInt();
                widget.onWeightChanged(_currentWeight);
              });
            },
          ),
        ),
      ],
    );
  }
}
