import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final double fieldHeight;
  final double borderRadius;
  final Color shadowColor;
  final Offset offset;
  final double spreadRadius;
  final double blurRadius;
  final Function()? onTap;
  final TextInputType textInputType;
  final int maxLines;
  final TextAlign textAlign;
  final double fontSize;
  final Color textColor;
  final String fontFamily;
  final double letterSpacing;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final String hintText;
  final Function(dynamic)? onSaved;
  final Color boxColor;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.fieldHeight = 50.0,
    this.borderRadius = 10.0,
    this.shadowColor = Colors.black12,
    this.offset = const Offset(0, 2),
    this.spreadRadius = 2.0,
    this.blurRadius = 5.0,
    this.onTap,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.fontSize = 16.0,
    this.textColor = Colors.black,
    this.fontFamily = 'Roboto',
    this.letterSpacing = 1.0,
    this.prefixIcon,
    this.suffixIcon,
    this.borderColor = Colors.grey,
    this.hintText = 'Enter text',
    this.boxColor = Colors.white,
    this.onSaved,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines == 1 ? fieldHeight : null,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.01),
            offset: offset,
            spreadRadius: spreadRadius,
            blurRadius: blurRadius,
          ),
        ],
      ),
      child: TextFormField(
        onTap: onTap,
        controller: controller,
        onSaved: onSaved,
        keyboardType: textInputType,
        inputFormatters: [
          if (textInputType == TextInputType.number)
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
          else
            FilteringTextInputFormatter.allow(RegExp(r'.*')),
        ],
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontFamily: fontFamily,
          letterSpacing: letterSpacing,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            color: textColor.withOpacity(0.5),
            letterSpacing: 1.1,
          ),
          fillColor: boxColor,
        ),
      ),
    );
  }
}
