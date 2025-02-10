// ignore_for_file: use_build_context_synchronously

// import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final hasAllowedGroupFeature =
    //     ref.read(userNotifierProvider)!.hasAllowedGroupFeature;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () {
              Navigator.pushNamed(context, '/add-expense');
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            // padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 8.h,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Center(
                    child: Text("Split Bills",
                        style: TextStyle(color: Colors.white, fontSize: 20.sp)),
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
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Still a work in progress—like your weekend plans.",
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
          ),
        ));
  }
}
