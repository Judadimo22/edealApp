import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:edeal/widgets/thumb.dart';

class Enumeracion extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double>? onChanged;

  Enumeracion({
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  @override
  _EnumeracionState createState() => _EnumeracionState();
}

class _EnumeracionState extends State<Enumeracion> {
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _sliderValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.035,
        right: MediaQuery.of(context).size.height * 0.035,
      ),
      child: Column(
        children: [
          Text(
            NumberFormat('#,###,###').format(_sliderValue),
            style: const TextStyle(fontSize: 12),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF0C67B0),
              inactiveTrackColor: const Color(0xFFE8E112),
              thumbColor: Colors.white,
              trackHeight: 4.0,
              thumbShape: const CustomSliderThumbShape(
                thumbRadius: 8.0,
                borderThickness: 2.0,
                borderColor: Colors.blue,
              ),
              overlayColor: const Color(0x00FFFFFF),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
            ),
            child: Slider(
              min: widget.min,
              max: widget.max,
              divisions: widget.divisions,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}