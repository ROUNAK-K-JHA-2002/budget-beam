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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _addFriend(String userId, WidgetRef ref) {
    if (_formKey.currentState!.validate()) {
      final newFriend = Friend(
        id: '',
        name: _nameController.text,
        email: _emailController.text,
        hasOnboarded: false,
        profilePicture: '',
      );
      getUserByEmail(_emailController.text, context).then((existingUser) {
        if (existingUser != null) {
          updateUser(
              userId,
              {
                'friends':
                    ref.read(userNotifierProvider)!.friends.map((friend) {
                  if (friend.email == _emailController.text) {
                    return Friend(
                      id: friend.id,
                      name: friend.name,
                      email: friend.email,
                      hasOnboarded: true,
                      profilePicture: existingUser.profilePhoto,
                    );
                  }
                  return friend;
                }).toList(),
              },
              context,
              ref);
        } else {
          updateUser(
              userId,
              {
                'friends': [
                  ...ref.read(userNotifierProvider)!.friends,
                  newFriend.toJson()
                ]
              },
              context,
              ref);
        }
      });
    }
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
                        child: Text('Name',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                        onSaved: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      CustomTextField(
                        controller: _emailController,
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
                          'If the user is not registered, an invite link will be sent to this email. Otherwise, they will be added directly to your friend list.',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: "Add Friend",
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _addFriend(user!.userId, ref);
                              Navigator.of(context).pop();
                            },
                          ),
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
