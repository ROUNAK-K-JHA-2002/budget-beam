import 'package:budgetbeam/components/backup.dart';
import 'package:budgetbeam/components/data_and_privacy.dart';
import 'package:budgetbeam/components/developer.dart';
import 'package:budgetbeam/components/invite.dart';
import 'package:budgetbeam/components/settings.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 35.h,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  SvgPicture.asset(
                    "assets/Images/homeBg.svg",
                    fit: BoxFit.cover,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Container(
                        //   padding: EdgeInsets.symmetric(horizontal: 5.w),
                        //   height: 10.h,
                        //   width: 100.w,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       IconButton(
                        //           onPressed: () {},
                        //           icon: const Icon(
                        //               Icons.arrow_back_ios_new_rounded,
                        //               color: Colors.white)),
                        //       Text(
                        //         "Profile",
                        //         style: TextStyle(
                        //             fontSize: 18.sp, color: Colors.white),
                        //       ),
                        //       IconButton(
                        //           onPressed: () {

                        //           },
                        //           icon: const Icon(Icons.logout,
                        //               color: Colors.white)),
                        //     ],
                        //   ),
                        // ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.network(
                            user?.profilePhoto ??
                                "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                            height: 10.h,
                            width: 10.h,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          user?.name ?? "Anonymous User",
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                        ),
                        Text(
                          user?.email ?? "Anonymous User",
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
                      case "Logout":
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
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
                                      context, '/login', (route) => false);
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
                    margin:
                        EdgeInsets.symmetric(vertical: 1.3.h, horizontal: 5.w),
                    child: Row(
                      children: [
                        Icon(
                          profileItems[index]['icon'],
                          size: 30,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          profileItems[index]['title'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: profileItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
