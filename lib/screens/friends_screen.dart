// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/routes/router.dart';
import 'package:budgetbeam/services/user_services.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FriendScreen extends ConsumerStatefulWidget {
  const FriendScreen({super.key});

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends ConsumerState<FriendScreen> {
  @override
  void initState() {
    super.initState();
    getUser(context, ref);
  }

  @override
  Widget build(BuildContext context) {
    final List<Friend> userFriends = ref.read(userNotifierProvider)!.friends;

    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Friends",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        Row(children: [
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, '/friend-requests', null);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(2.w),
                              child: const Icon(Icons.notifications,
                                  color: kPrimaryColor),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, '/add-friend', null);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: kSecondaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(2.w),
                              child: const Icon(Icons.person_add,
                                  color: kSecondaryColor),
                            ),
                          )
                        ]),
                      ]),
                  SizedBox(height: 2.h),
                  Expanded(
                    child: userFriends.isEmpty
                        ? Text(
                            "No Friends Added yet",
                            style: TextStyle(fontSize: 15.sp),
                          )
                        : ListView.builder(
                            itemCount: userFriends.length,
                            itemBuilder: (context, index) {
                              if (userFriends.isEmpty) {
                                return const Text("No Friends Added yet");
                              } else {
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    margin: EdgeInsets.symmetric(vertical: 1.h),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2.h, horizontal: 3.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                              child: Image.network(
                                                  userFriends[index]
                                                      .profilePicture,
                                                  width: 10.w,
                                                  height: 10.w,
                                                  fit: BoxFit.cover),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            SizedBox(width: 4.w),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userFriends[index].name,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(userFriends[index].email),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        )
                                      ],
                                    ));
                              }
                            },
                          ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    ));
  }
}
