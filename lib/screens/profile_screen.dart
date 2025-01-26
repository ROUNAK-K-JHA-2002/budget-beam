import 'package:budgetbeam/components/backup.dart';
import 'package:budgetbeam/components/data_and_privacy.dart';
import 'package:budgetbeam/components/developer.dart';
import 'package:budgetbeam/components/feedback_bug.dart';
import 'package:budgetbeam/components/invite.dart';
import 'package:budgetbeam/components/settings.dart';
import 'package:budgetbeam/components/upgrade.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/ads_service.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final user = ref.watch(userNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 33.h,
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: user?.hasOnboarded == true
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.orange,
                                    Colors.yellow,
                                    Colors.green,
                                    Colors.blue,
                                    Colors.indigo,
                                    Colors.purple,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                                ],
                              )
                            : null, // No border for non-premium users
                        padding: user?.hasOnboarded == true
                            ? const EdgeInsets.all(4.0)
                            : EdgeInsets.zero, // Border thickness
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            imageUrl: user?.profilePhoto ??
                                "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                            height: 10.h,
                            width: 10.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        user?.name ?? "Anonymous User",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        user?.email ?? "Anonymous User",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  width: 100.w,
                  height: 50.h,
                  child: ListView.builder(
                    itemCount: profileItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch (profileItems[index]['title']) {
                            case "Settings":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const Settings());
                              break;
                            case "Invite Friends":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const Invite());
                              break;
                            case "Data and Privacy":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const DataAndPrivacy());
                              break;
                            case "Upgrade to Premium":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const Upgrade());
                              break;
                            case "Backup and Restore":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const Backup());
                              break;
                            case "Developer Contact":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const Developer());
                              break;
                            case "Feedback / Bug Report":
                              showBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  showDragHandle: false,
                                  context: context,
                                  builder: (context) => const FeedbackBug());
                              break;
                            case "Logout":
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Logout"),
                                  content: const Text(
                                      "Are you sure you want to logout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (route) => false);
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              break;
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 1.h, horizontal: 5.w),
                          width: 90.w,
                          child: Row(
                            children: [
                              Icon(
                                profileItems[index]['icon'],
                                size: 25,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                profileItems[index]['title'],
                                style: TextStyle(
                                  fontSize: 15.5.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Version 1.0.0-patch-test-0.27",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Copyright © 2025 Dextrix Technology Group",
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
