// ignore_for_file: unused_field

import 'package:budgetbeam/components/date_picker.dart';
import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _type = 'spend';
  DateTime _date = DateTime.now();
  String _tag = 'food';

  late ObjectBoxStore _objectBoxStore;

  @override
  void initState() {
    super.initState();
    _objectBoxStore = ObjectBoxStore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: 100.w,
          height: 100.h,
          child: Stack(alignment: Alignment.topCenter, children: [
            SvgPicture.asset(
              "assets/Images/homeBg.svg",
              width: 100.w,
            ),
            Positioned(
              width: 100.w,
              top: 7.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                  Text(
                    "Add Expense",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Positioned(
              top: 20.h,
              child: Container(
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        hintText: 'Enter Name',
                        shadowColor: Colors.grey.shade300,
                        fontSize: 16.0,
                        textColor: Colors.black,
                        controller: _nameController,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Amount",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      CustomTextField(
                        hintText: 'Enter Amount',
                        shadowColor: Colors.grey.shade300,
                        textInputType: TextInputType.number,
                        fontSize: 16.0,
                        textColor: Colors.black,
                        controller: _amountController,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Type ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      CustomDropdown(
                          options: types,
                          onChanged: (value) => setState(() => _type = value)),
                      SizedBox(height: 2.h),
                      Text(
                        "Tag",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      CustomDropdown(
                          options: tags,
                          onChanged: (value) => setState(() => _tag = value)),
                      SizedBox(height: 2.h),
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      CustomDatePicker(onDateSelected: (selecteddate) {
                        setState(() => _date = selecteddate);
                      }),
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
                                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                                decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  border: Border.all(color: Colors.transparent),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 20,
                                      offset: Offset(-2, -2),
                                    ),
                                    BoxShadow(
                                      color: Color.fromARGB(255, 185, 187, 192),
                                      blurRadius: 20,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                ),
                                duration: const Duration(milliseconds: 50),
                                child: Text(
                                  "Submit",
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
            ),
          ]),
        ));
  }

  void _submitForm(BuildContext context) {
    try {
      _objectBoxStore.saveExpenseToDB(_nameController.text,
          int.parse(_amountController.text), _date, _tag, _type);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expense added successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to add expense.')));
      debugPrint("Failed to save expense: $e");
    }
  }
}
