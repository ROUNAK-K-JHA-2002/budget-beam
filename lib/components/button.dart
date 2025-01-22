import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onPressed;
  final Color textColor;
  final bool isOutlined;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.textColor = Colors.white,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 70.w,
        height: 6.h,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: isOutlined
          //       ? [Colors.white, Colors.white]
          //       : [kSecondaryColor, kPrimaryColor],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          color: !isOutlined ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color:
                  !isOutlined ? kPrimaryColor.withOpacity(0.3) : Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(1, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            else
              icon,
            SizedBox(width: 2.w),
            Text(
              text,
              style: TextStyle(
                color: isOutlined ? kPrimaryDark : textColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
