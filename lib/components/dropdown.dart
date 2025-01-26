import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String? initialValue;
  final Function(String) onChanged;
  final bool? isCompact;

  const CustomDropdown(
      {super.key,
      required this.options,
      this.isCompact = false,
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
      padding: EdgeInsets.symmetric(
          horizontal: widget.isCompact! ? 2.w : 3.w,
          vertical: widget.isCompact! ? 0.1.h : 0.5.h),
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
                    size: widget.isCompact! ? 16.sp : 20.sp,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    option['text'],
                    style: TextStyle(
                      fontSize: widget.isCompact! ? 14.sp : 15.sp,
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
          size: widget.isCompact! ? 18.sp : 22.sp,
        ),
        underline: const SizedBox(),
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
