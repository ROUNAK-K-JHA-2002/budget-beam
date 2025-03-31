// ignore_for_file: library_private_types_in_public_api

import 'package:budgetbeam/components/button.dart';
import 'package:budgetbeam/services/user_services.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddFriend extends ConsumerStatefulWidget {
  const AddFriend({super.key});

  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends ConsumerState<AddFriend> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  void _addFriendRequest(UserModel user, WidgetRef ref) async {
    _loading.value = true;
    if (_formKey.currentState!.validate()) {
      FriendRequest friendRequest = FriendRequest(
        name: user.name,
        userId: user.userId,
        email: user.email,
        profilePicture: user.profilePhoto,
        createdAt: DateTime.now(),
        recieverEmail: _emailController.text,
        status: "pending",
      );
      bool isSuccess = await sendFriendRequest(friendRequest, context);
      if (isSuccess) {
        Navigator.of(context).popUntil((route) {
          return route.settings.name == "/";
        });
      }
    }
    _loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: 100.w,
          color: kPrimaryColor,
          height: 100.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 10.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Add Friend",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 3.w),
                  ],
                ),
              ),
              Container(
                width: 100.w,
                height: 85.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/Images/bg.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email),
                        hintText: 'Email',
                        onSaved: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'If the user is not registered, an invite link will be sent to this email. Otherwise, they will recieve a friend request in-app.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: _loading,
                              builder: (context, value, child) {
                                return CustomButton(
                                  isLoading: value,
                                  text: "Add Friend",
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    _addFriendRequest(user!, ref);
                                    // Navigator.of(context).pop();
                                  },
                                );
                              })
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
