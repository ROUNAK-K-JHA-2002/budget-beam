import 'package:budgetbeam/main.dart';
import 'package:budgetbeam/screens/login_screen.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // margin: EdgeInsets.symmetric(vertical: 2.h),
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/login.png'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: SizedBox(
                height: 70.h,
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/Images/onboard1.png',
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        Text("Manage Your  ",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        Text("Finances ",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600)),
                        Text("Effortlessly",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Text(
                        "Easily track your expenses and visualize spending habits with detailed insights. Your personal finance data is stored offline on your device, ensuring complete privacy.",
                        style: TextStyle(fontSize: 15.sp)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: SizedBox(
                height: 70.h,
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/Images/onboard2.png',
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                    Row(
                      children: [
                        Text("Simplify  ",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                        Text("Group Expenses ",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                        "Manage shared expenses with real-time syncing. Perfect for families, friends, or roommates, keeping everyone updated without compromising privacy.",
                        style: TextStyle(fontSize: 15.sp)),
                  ],
                ),
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: SizedBox(
                height: 70.h,
                width: 90.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/Images/onboard3.png',
                      width: 90.w,
                      height: 90.w,
                    ),
                    Row(
                      children: [
                        Text("Analyze ",
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600)),
                        Text("Your Spendings ",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                        "View clear, easy-to-read charts and graphs to track where your money goes. Make smarter financial decisions with actionable insights.",
                        style: TextStyle(fontSize: 15.sp)),
                  ],
                ),
              ),
            ),
          ],
          showSkipButton: false,
          showNextButton: true,
          // skip: const Text("Skip"),
          next: Container(
            width: 30.w,
            height: 4.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text("Continue",
                style: TextStyle(fontSize: 15.sp, color: Colors.white)),
          ),
          done: Container(
            width: 30.w,
            height: 4.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text("Proceed",
                style: TextStyle(fontSize: 15.sp, color: Colors.white)),
          ),
          onDone: () {
            storage.write(key: 'onboarding', value: 'true');

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
            // On button pressed
          },
        ),
      ),
    );
  }
}
