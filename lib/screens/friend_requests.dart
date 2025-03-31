// ignore_for_file: must_be_immutable

import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/friend_requests.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FriendRequestScreen extends ConsumerStatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  _FriendRequestScreenState createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends ConsumerState<FriendRequestScreen> {
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  List<FriendRequest> friendRequests = [];
  late final user;

  @override
  void initState() {
    super.initState();
    user = ref.read(userNotifierProvider);
    _loadData();
  }

  void _loadData() async {
    isLoading.value = true;
    friendRequests = await ref
        .read(friendRequestsNotifierProvider.notifier)
        .fetchFriendRequests(user.email, context);
    isLoading.value = false;
  }

  void _acceptFriendRequest(String senderEmail) async {
    try {
      // print(user.toString());

      // final friend = Friend(
      //     name: user.name,
      //     email: user.email,
      //     profilePicture: user.profilePicture);

      var querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: senderEmail)
          .get();
      var document = querySnapshot.docs.first;
      print(document.data());
    } catch (e) {
      debugPrint(e.toString());
      showErrorSnackbar("Failed to accept friend request! Please try again");
    }
  }

  void _rejectFriendRequest(String senderEmail) async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('friend_requests')
          .where('email', isEqualTo: senderEmail)
          .get();
      await querySnapshot.docs.first.reference.delete();
    } catch (e) {
      debugPrint(e.toString());
      showErrorSnackbar("Failed to reject friend request! Please try again");
    }
  }

  @override
  Widget build(BuildContext context) {
    print(friendRequests.length);
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            width: 100.w,
            height: 100.h,
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
                      margin: EdgeInsets.only(top: 2.h),
                      width: 100.w,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            "Friend Requests",
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 2.w),
                    width: 100.w,
                    child: Text(
                      "All the friend requests you have received will be displayed here.",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: (context, value, child) {
                        return Container(
                            padding: EdgeInsets.all(1.w),
                            height: 90.h,
                            child: Container(
                              child: value
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      itemCount: friendRequests.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.5.h,
                                                horizontal: 3.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 10,
                                                  spreadRadius: 2,
                                                )
                                              ],
                                            ),
                                            width: 100.w,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            friendRequests[
                                                                    index]
                                                                .profilePicture,
                                                        height: 6.h,
                                                        width: 6.h,
                                                        fit: BoxFit.cover,
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    SizedBox(width: 3.w),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            friendRequests[
                                                                    index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            friendRequests[
                                                                    index]
                                                                .email,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    13.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 2.w,
                                                              vertical: 0.4.h),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .purpleAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: Text(
                                                        friendRequests[index]
                                                            .status
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 1.5.h),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _rejectFriendRequest(
                                                            friendRequests[
                                                                    index]
                                                                .email);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    0.7.h),
                                                        width: 30.w,
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 17.sp,
                                                            ),
                                                            SizedBox(
                                                              width: 1.w,
                                                            ),
                                                            Text(
                                                              "Reject",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      15.sp),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _acceptFriendRequest(
                                                            friendRequests[
                                                                    index]
                                                                .email);
                                                      },
                                                      child: Container(
                                                        width: 30.w,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    0.7.h),
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 17.sp,
                                                            ),
                                                            SizedBox(
                                                              width: 1.w,
                                                            ),
                                                            Text(
                                                              "Accept",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(height: 1.h),
                                                SizedBox(
                                                    width: 80.w,
                                                    child: Text(
                                                      "Sent on ${DateFormat('dd/MM/yyyy').format(friendRequests[index].createdAt)}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade400),
                                                    )),
                                              ],
                                            ));
                                      },
                                    ),
                            ));
                      })
                ],
              ),
            )),
      ),
    );
  }
}
