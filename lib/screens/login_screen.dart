// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/sign_in.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> handleSignInProcess(String type, WidgetRef ref) async {
    if (type == 'google') {
      User? user = await signInWithGoogle();
      if (user != null) {
        UserState userState = UserState(
          email: user.email ?? '',
          name: user.displayName ?? '',
          profilePhoto: user.photoURL ?? '',
          isAnonymous: user.isAnonymous,
        );
        ref.read(userNotifierProvider.notifier).setUser(userState);
        Navigator.popAndPushNamed(context, '/');
      }
    } else if (type == 'anonymous') {
      User? user = await signInWithAnonymously();
      if (user != null) {
        Navigator.popAndPushNamed(context, '/');
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(builder: (context, ref, child) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            height: 100.h,
            width: 100.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Images/LoginBG.png'),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset('assets/Images/Coint.png'),
                    Image.asset(
                      'assets/Images/Man.png',
                      height: 40.h,
                    ),
                    // Image.asset('assets/Images/Donut.png'),
                  ],
                ),
                Text(
                  'Spend Smarter \n Save More',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                Column(
                  children: [
                    SignInButtonBuilder(
                      fontSize: 15.sp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      text: 'Continue with Google',
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      image: SvgPicture.asset(
                        'assets/Images/google.svg',
                        height: 2.7.h,
                      ),
                      backgroundColor: Colors.white,
                      textColor: kPrimaryColor,
                      onPressed: () {
                        handleSignInProcess('google', ref);
                      },
                    ),
                    SizedBox(height: 2.h),
                    SignInButtonBuilder(
                      fontSize: 15.sp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      text: 'Continue Anonymously',
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                      icon: Icons.person,
                      backgroundColor: kPrimaryColor,
                      onPressed: () {
                        handleSignInProcess('anonymous', ref);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
