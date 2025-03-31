// ignore_for_file: unused_field

import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
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
  final List<Friend> _selectedFriends = [];
  late List<Friend> _friends;
  late ObjectBoxStore _objectBoxStore;

  @override
  void initState() {
    super.initState();
    _objectBoxStore = ObjectBoxStore.instance;
    _friends = ref.read(userNotifierProvider)!.friends;
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
                                print(_friends.isEmpty);
                                return _friends.isEmpty
                                    ? const Text("No friends found")
                                    : CheckboxListTile(
                                        title: Text(_friends[index].name),
                                        value: _selectedFriends
                                            .contains(_friends[index]),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value == true) {
                                              _selectedFriends
                                                  .add(_friends[index]);
                                            } else {
                                              _selectedFriends
                                                  .remove(_friends[index]);
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
                              GestureDetector(
                                  onTap: () async {
                                    _submitForm(context);
                                  },
                                  child: AnimatedContainer(
                                    alignment: Alignment.center,
                                    width: 80.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.5.h),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      border:
                                          Border.all(color: Colors.transparent),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 20,
                                          offset: Offset(-2, -2),
                                        ),
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              255, 158, 134, 243),
                                          blurRadius: 20,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                    ),
                                    duration: const Duration(milliseconds: 50),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16.sp),
                                    ),
                                  ))
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

  void _submitForm(BuildContext context) {
    // Implement the logic to save the group to the database
    // For example:
    // _objectBoxStore.saveGroupToDB(
    //     _nameController.text,
    //     _selectedFriends,
    //     _category);
    // ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Group added successfully!')));
    // Navigator.pop(context);
  }
}
