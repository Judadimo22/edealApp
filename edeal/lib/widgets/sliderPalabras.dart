import 'package:flutter/material.dart';
import 'package:edeal/widgets/thumb.dart';

class CustomWordSliderWidget extends StatefulWidget {
  final String value;
  final List<String> words;
  final ValueChanged<String>? onChanged;

  CustomWordSliderWidget({
    required this.value,
    required this.words,
    required this.onChanged,
  });

  @override
  _CustomWordSliderWidgetState createState() => _CustomWordSliderWidgetState();
}

class _CustomWordSliderWidgetState extends State<CustomWordSliderWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.words.indexOf(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.height * 0.035,
        right: MediaQuery.of(context).size.height * 0.035,
        bottom: MediaQuery.of(context).size.height * 0.045,
      ),
      child: Column(
        children: [
          Text(
            widget.value,
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
              min: 0,
              max: widget.words.length - 1,
              divisions: widget.words.length - 1,
              value: _selectedIndex.toDouble(),
              onChanged: (value) {
                setState(() {
                  _selectedIndex = value.round();
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(widget.words[_selectedIndex]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}



