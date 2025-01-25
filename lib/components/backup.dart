import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Backup extends StatefulWidget {
  const Backup({super.key});

  @override
  State<Backup> createState() => _BackupState();
}

class _BackupState extends State<Backup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Backup and Restore",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 20.sp,
                ),
              )
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            "Backup your data and restore it later using Google Drive.",
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/Images/coming_soon.png',
              // height: 20.h,
              width: 60.w,
            ),
          ),
          SizedBox(height: 2.h),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Oops! This screen's still in the oven. Patience, chef!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
