import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String? initialValue;
  final Function(String) onChanged;

  const CustomDropdown(
      {super.key,
      required this.options,
      required this.onChanged,
      this.initialValue});

  @override
  // ignore: library_private_types_in_public_api
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialValue ?? widget.options.first['text'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: selectedOption,
        onChanged: (String? newValue) {
          setState(() {
            selectedOption = newValue!;
            widget.onChanged(selectedOption);
          });
        },
        items: widget.options
            .map<DropdownMenuItem<String>>((Map<String, dynamic> option) {
          return DropdownMenuItem<String>(
              value: option['text'],
              child: Row(
                children: [
                  Icon(
                    option['icon'],
                    color: option['color'],
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    option['text'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ));
        }).toList(),
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.grey[800],
          size: 30,
        ),
        underline: const SizedBox(),
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
