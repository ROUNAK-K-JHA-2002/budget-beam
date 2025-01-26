// ignore_for_file: unused_field

import 'package:budgetbeam/components/date_picker.dart';
import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/constants.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddExpense extends StatefulWidget {
  final ExpenseEntity? expense;

  const AddExpense({this.expense, super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _type = types[0];
  DateTime _date = DateTime.now();
  String _category = categories[0]['text'];
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  late ObjectBoxStore _objectBoxStore;

  @override
  void initState() {
    super.initState();
    _objectBoxStore = ObjectBoxStore.instance;
    if (widget.expense != null) {
      setState(() {
        _nameController.text = widget.expense!.name;
        _amountController.text = widget.expense!.amount.toString();
        _date = widget.expense!.dateCreated;
        _category = widget.expense!.category;
        selectedIndex.value = types.indexOf(
            widget.expense!.type[0].toUpperCase() +
                widget.expense!.type.substring(1).toLowerCase());
      });
    }
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
                  // SvgPicture.asset(
                  //   "assets/Images/homeBg.svg",
                  //   width: 100.w,
                  // ),
                  Container(
                    height: 10.h,
                    decoration: const BoxDecoration(
                      // color: kPrimaryColor,
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
                          "Add Expense",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        if (widget.expense != null)
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Delete Expense"),
                                  content: const Text(
                                      "Are you sure you want to delete this expense?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _objectBoxStore.deleteExpenseFromDB(
                                            widget.expense!.id);

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Delete',
                                          style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );

                              //  showDialog(context: context, builder: (conte;)
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        else
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
                          topRight: Radius.circular(20)),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Title",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  // color: Colors.black,
                                ),
                              ),
                              const Text("*",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            hintText: 'Enter Title',
                            // fontSize: 16.0,
                            controller: _nameController,
                            prefixIcon: const Icon(Icons.note),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  // color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 1.w),
                              const Text("*",
                                  style: TextStyle(color: Colors.red)),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          CustomTextField(
                            hintText: 'Enter Amount',
                            textInputType: TextInputType.number,
                            prefixIcon: const Icon(Icons.currency_rupee),
                            controller: _amountController,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Type ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              // color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          SizedBox(
                            width: 100.w,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 5.w,
                              children: List<Widget>.generate(
                                types.length,
                                (int index) {
                                  return ValueListenableBuilder(
                                      valueListenable: selectedIndex,
                                      builder: (context, value, child) {
                                        return InputChip(
                                          labelPadding: EdgeInsets.symmetric(
                                              horizontal: 10.w,
                                              vertical: 0.2.h),
                                          label: Text(types[index]),
                                          selected:
                                              selectedIndex.value == index,
                                          backgroundColor: Colors.white,
                                          elevation: 2,
                                          onSelected: (bool selected) {
                                            selectedIndex.value = index;
                                            _type = types[index];
                                          },

                                          // onDeleted: () {
                                          //
                                        );
                                      });
                                },
                              ).toList(),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            "Categories",
                            style: TextStyle(
                              fontSize: 16.sp,
                              // color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomDropdown(
                              initialValue: widget.expense?.category,
                              options: categories,
                              onChanged: (value) {
                                setState(() => _category = value);
                              }),
                          SizedBox(height: 2.h),
                          Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 16.sp,
                              // color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          CustomDatePicker(
                              initialDate: widget.expense?.dateCreated,
                              onDateSelected: (selecteddate) {
                                setState(() => _date = selecteddate);
                              }),
                          SizedBox(height: 4.h),
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
                                      widget.expense != null
                                          ? "Update"
                                          : "Save",
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
    try {
      _objectBoxStore.saveExpenseToDB(
          widget.expense?.id ?? 0,
          _nameController.text,
          int.parse(_amountController.text),
          _date,
          _category,
          types[selectedIndex.value].toLowerCase(),
          widget.expense != null ? true : false);
      showSuccessSnackbar("Expense added successfully!");
      Navigator.pop(context);
    } catch (e) {
      showErrorSnackbar("Failed to save expense.");
      debugPrint("Failed to save expense: $e");
    }
  }
}
