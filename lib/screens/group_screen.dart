// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/models/group_model.dart';
import 'package:budgetbeam/provider/group_list_provider.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/routes/router.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupScreen extends ConsumerStatefulWidget {
  const GroupScreen({super.key});

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends ConsumerState<GroupScreen> {
  void initState() {
    super.initState();
    _fetchGroups();
  }

  void _fetchGroups() {
    final userId = ref.read(userNotifierProvider)!.userId;
    ref
        .read(groupNotifierProvider.notifier)
        .fetchGroupsByUserId(userId, context);
  }

  @override
  Widget build(BuildContext context) {
    final List<GroupModel> userGroups = ref.watch(groupNotifierProvider);

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
                            "Your Groups",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: kPrimaryColor,
                            onPressed: () {
                              navigateTo(context, '/add-group', null);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.add, color: Colors.white),
                                SizedBox(width: 2.w),
                                const Text("Add Group",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          )
                        ]),
                    SizedBox(height: 2.h),
                    Expanded(
                        child: userGroups.isEmpty
                            ? Text(
                                "No Groups Added yet",
                                style: TextStyle(fontSize: 15.sp),
                              )
                            : ListView.builder(
                                itemCount: userGroups.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.h, horizontal: 3.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                blurRadius: 5,
                                                spreadRadius: 2)
                                          ]),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 2.w),
                                                alignment: Alignment.center,
                                                height: 5.h,
                                                width: 5.h,
                                                decoration: BoxDecoration(
                                                    color:
                                                        categories.firstWhere(
                                                      (element) {
                                                        return element[
                                                                'text'] ==
                                                            userGroups[index]
                                                                .groupCategory;
                                                      },
                                                      orElse: () => {
                                                        'color': kPrimaryColor
                                                      },
                                                    )['color'][100],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Icon(
                                                  categories.firstWhere(
                                                      (element) {
                                                    return element['text'] ==
                                                        userGroups[index]
                                                            .groupCategory;
                                                  },
                                                      orElse: () => {
                                                            'color':
                                                                kPrimaryColor
                                                          })['icon'],
                                                  color: categories.firstWhere(
                                                    (element) {
                                                      return element['text'] ==
                                                          userGroups[index]
                                                              .groupCategory;
                                                    },
                                                    orElse: () => {
                                                      'color': kPrimaryColor
                                                    },
                                                  )['color'],
                                                ),
                                              ),
                                              Text(
                                                userGroups[index].groupName,
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 1.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                Text(
                                                  "Members: ",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  userGroups[index]
                                                      .numberOfMembers
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kPrimaryColor),
                                                ),
                                              ]),
                                              Row(children: [
                                                Text(
                                                  "Spendings: ₹",
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  userGroups[index]
                                                      .totalSpendings
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: kPrimaryColor),
                                                ),
                                              ])
                                            ],
                                          )
                                        ],
                                      ));
                                },
                              ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
