import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';

class Invite extends StatefulWidget {
  const Invite({super.key});

  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invite",
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
            Text(
              "Your friends will thank you for sharing BudgetBeam!",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Budgeting is better with friends! Share BudgetBeam with your friends and family so they can start managing their money effectively today.",
              style: TextStyle(
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/Images/rewards.png", width: 60.w),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () async {
                    await Share.share(
                        'Check out BudgetBeam! Your very own secure personal finance app. https://appdistribution.firebase.dev/i/a46c6c875c18905c');
                  },
                  child: const Text("Share the App",
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
