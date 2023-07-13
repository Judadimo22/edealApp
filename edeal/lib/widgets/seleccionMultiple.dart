import 'package:flutter/material.dart';

class MultiSelectWidget extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onChanged;

  const MultiSelectWidget({
    required this.options,
    required this.selectedOptions,
    required this.onChanged,
  });

  

  @override
  _MultiSelectWidgetState createState() => _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends State<MultiSelectWidget> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
  }

  void _handleOptionChanged(String option, bool selected) {
    setState(() {
      if (selected) {
        _selectedOptions.add(option);
      } else {
        _selectedOptions.remove(option);
      }
    });
    widget.onChanged(_selectedOptions);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.options.length,
            itemBuilder: (context, index) {
              final option = widget.options[index];
              final selected = _selectedOptions.contains(option);
              return CheckboxListTile(
                title: Text(option),
                value: selected,
                onChanged: (value) => _handleOptionChanged(option, value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          ),
        ],
      ),
    );
  }
}
