// ignore_for_file: unused_field

import 'dart:math';

import 'package:budgetbeam/components/button.dart';
import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/models/group_model.dart';
import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/services/user_services.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddGroup extends ConsumerStatefulWidget {
  const AddGroup({super.key});

  @override
  ConsumerState<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends ConsumerState<AddGroup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String _category = categories[0]['text'];
  final List<Member> _selectedFriends = [];
  late List<Friend> _friends;
  late UserModel user;
  late ObjectBoxStore _objectBoxStore;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _objectBoxStore = ObjectBoxStore.instance;
    _friends = ref.read(userNotifierProvider)!.friends;
    user = ref.read(userNotifierProvider)!;
  }

  String generateInviteCode() {
    final random = Random();
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return String.fromCharCodes(Iterable.generate(
        6, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  void _submitForm(BuildContext context) async {
    _isLoading.value = true;
    try {
      if (_nameController.text.isEmpty) {
        showErrorSnackbar("Group name cannot be empty");
        _isLoading.value = false;
        return;
      }
      _selectedFriends.add(Member(
          id: user.userId, name: user.name, photoUrl: user.profilePhoto));
      var docRef = await FirebaseFirestore.instance.collection("groups").doc();
      var groupData = GroupModel(
          groupId: docRef.id,
          groupName: _nameController.text,
          groupCategory: _category,
          inviteCode: generateInviteCode(),
          numberOfMembers: 2,
          totalSpendings: 0,
          createdAt: DateTime.now(),
          isPremiumGroup: false,
          members: _selectedFriends,
          transactions: []);

      print(groupData.toJson());

      await docRef.set(groupData.toJson());

      for (var member in _selectedFriends) {
        var userGroupData = Group(
            id: docRef.id,
            createdAt: DateTime.now(),
            isAdmin: true,
            name: _nameController.text,
            totalMembers: 2,
            totalSpendings: 0,
            groupCategory: _category);

        var userData = {
          "groups": FieldValue.arrayUnion([userGroupData.toJson()])
        };

        await updateUser(member.id, userData, context, ref);
      }
      await getUser(user.userId, context, ref);

      Navigator.of(context).popUntil((route) {
        return route.settings.name == "/";
      });
    } catch (e) {
      print(e);
      showErrorSnackbar("Failed to create group");
    }
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
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
                          bottomRight: Radius.circular(16.0)),
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
                            )),
                        Text(
                          "Add Group",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 3.w)
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
                          topRight: Radius.circular(20)),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Group Name",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            prefixIcon: Icon(Icons.group),
                            textInputType: TextInputType.name,
                            hintText: 'Enter Group Name',
                            shadowColor: Colors.grey.shade300,
                            fontSize: 16.0,
                            textColor: Colors.black,
                            controller: _nameController,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Category",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomDropdown(
                              options: categories,
                              onChanged: (value) {
                                setState(() => _category = value);
                              }),
                          SizedBox(height: 2.h),
                          Text(
                            "Friends",
                            style: TextStyle(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Expanded(
                            child: ListView.builder(
                              itemCount: _friends.length,
                              itemBuilder: (context, index) {
                                return _friends.isEmpty
                                    ? const Text("No friends found")
                                    : CheckboxListTile(
                                        title: Text(_friends[index].name),
                                        value: _selectedFriends.any((member) =>
                                            member.id ==
                                            _friends[index].userId),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value == true) {
                                              _selectedFriends.add(Member(
                                                  id: _friends[index].userId,
                                                  name: _friends[index].name,
                                                  photoUrl: _friends[index]
                                                      .profilePicture));
                                            } else {
                                              _selectedFriends.removeWhere(
                                                  (member) =>
                                                      member.id ==
                                                      _friends[index].userId);
                                            }
                                          });
                                        },
                                      );
                              },
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Note: Group data are synced with Budgetbeam server unlike personal expenses which are stored on the device.",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: _isLoading,
                                  builder: (context, value, child) {
                                    return CustomButton(
                                        isLoading: value,
                                        text: "Save",
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _submitForm(context);
                                        });
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }
}
