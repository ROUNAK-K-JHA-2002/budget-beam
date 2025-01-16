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
        margin: EdgeInsets.symmetric(vertical: 2.h),
        width: 100.w,
        height: 100.h,
        child: IntroductionScreen(
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Welcome to Budget Beam",
              body: "Your personal finance assistant",
            ),
            PageViewModel(
              title: "Welcome to Budget Beam",
              body: "Your personal finance assistant",
            ),
            PageViewModel(
              title: "Welcome to Budget Beam",
              body: "Your personal finance assistant",
            ),
          ],
          showSkipButton: true,
          showNextButton: false,
          skip: const Text("Skip"),
          done: const Text("Done"),
          onDone: () {
            // On button pressed
          },
        ),
      ),
    );
  }
}
