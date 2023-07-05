import 'package:flutter/material.dart';

class CustomDropdownWidget extends StatefulWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final List<String> items;

  const CustomDropdownWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  void handleValueChanged(String? newValue) {
    if (newValue != null) {
      widget.onChanged(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * 1,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.005,
        left: MediaQuery.of(context).size.height * 0.045,
        right: MediaQuery.of(context).size.height * 0.045,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF0C67B0),
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.008,
          horizontal: MediaQuery.of(context).size.height * 0.010,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            value: widget.value,
            onChanged: handleValueChanged,
            items: widget.items
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 0.002),
                  child: Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFFABB3B8),
                    ),
                  ),
                ),
              );
            }).toList(),
            underline: null,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF0C67B0),
            ),
          ),
        ),
      ),
    );
  }
}
