import 'package:budgetbeam/components/button.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Upgrade extends StatefulWidget {
  final bool isSettingsScreen;
  const Upgrade({super.key, this.isSettingsScreen = true});

  @override
  State<Upgrade> createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                if (widget.isSettingsScreen)
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
            SizedBox(height: 1.h),
            Text(
              "Upgrade to BudgetBeam Pro!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              "Get advanced spending analysis and enjoy an ad-free experience for a one-time payment of just ₹199.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 2.h),
            Image.asset(
              "assets/Images/upgrade.png",
              width: 80.w,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 2.h),
            CustomButton(
              text: "Upgrade for ₹199",
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                // Add your payment logic here
              },
            ),
            SizedBox(height: 2.h),
            CustomButton(
              isOutlined: true,
              text: "Continue with Free (Ads)",
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                // Add logic for free continuation
              },
            ),
            SizedBox(height: 2.h),
            Text(
              "🔒 100% Secure Payment | One-Time Payment, Lifetime Access",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'By continuing, you agree to our',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 1.w),
                GestureDetector(
                  onTap: () {
                    // Navigate to Terms of Service
                  },
                  child: Text(
                    'Terms of Service ',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(width: 1.w),
                Text(
                  'and',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 1.w),
                GestureDetector(
                  onTap: () {
                    // Navigate to Privacy Policy
                  },
                  child: Text(
                    'Privacy Policy.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
