// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/components/button.dart';
import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/services/sign_in.dart';
import 'package:budgetbeam/services/user_services.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> handleSignInProcess(String type, WidgetRef ref) async {
    isLoading.value = true;
    if (type == 'google') {
      await signInWithGoogle();
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserModel? firebaseUser = await getUser(user.uid, context, ref);
        if (firebaseUser == null) {
          createUser(
              UserModel(
                  createdAt: DateTime.now(),
                  userId: user.uid,
                  email: user.email ?? '',
                  groups: [],
                  dailyLimit: '0',
                  friends: [],
                  hasOnboarded: true,
                  referralCode: generateStructuredReferralCode(),
                  isConsentUsingApp: true,
                  name: user.displayName ?? '',
                  plan: 'Free Plan',
                  subscriptionPurchaseDate: null,
                  subscriptionAmount: null,
                  subscriptionDetails: null,
                  profilePhoto: user.photoURL ?? ''),
              context,
              ref);
        }
        Navigator.popAndPushNamed(context, '/', arguments: {"isNewUser": true});
      }
    } else if (type == 'anonymous') {
      User? user = await signInWithAnonymously();
      if (user != null) {
        Navigator.popAndPushNamed(context, '/');
      }
    }
    isLoading.value = false;
  }

  final Shader linearGradient = const LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 235, 0, 243),
      Color.fromARGB(255, 1, 78, 165)
    ],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Consumer(builder: (context, ref, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/login.png'),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Images/logo.png',
                    width: 12.w,
                    height: 12.w,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Budget Beam',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      // color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                'Spend Smarter \nSave More',
                // textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w500,
                    foreground: Paint()..shader = linearGradient),
              ),
              // Text(
              //   'Your Privacy is Protected',
              //   textAlign: TextAlign.left,
              //   style: TextStyle(
              //     fontSize: 15.sp,
              //     fontWeight: FontWeight.w300,
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(height: 5.h),
              Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: isLoading,
                    builder: (context, value, child) {
                      return CustomButton(
                        text: 'Continue with Google',
                        isLoading: value,
                        icon: SvgPicture.asset(
                          'assets/Images/google.svg',
                          width: 7.w,
                          height: 7.w,
                        ),
                        onPressed: () {
                          if (value) {
                            return;
                          }
                          handleSignInProcess('google', ref);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 2.h),
                  // ValueListenableBuilder(
                  //   valueListenable: isLoading,
                  //   builder: (context, value, child) {
                  //     return CustomButton(
                  //       isLoading: isLoading.value,
                  //       text: 'Continue Anonymously',
                  //       isOutlined: true,
                  //       icon: const Icon(
                  //         Icons.person,
                  //       ),
                  //       onPressed: () {
                  //         if (value) {
                  //           return;
                  //         }
                  //         handleSignInProcess('anonymous', ref);
                  //       },
                  //     );
                  //   },
                  // ),
                  SizedBox(height: 2.h),
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
                      Text(
                        'Terms of Service ',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
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
                      Text(
                        'Privacy Policy.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}
