import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FeedbackBug extends StatefulWidget {
  const FeedbackBug({super.key});

  @override
  State<FeedbackBug> createState() => _FeedbackBugState();
}

class _FeedbackBugState extends State<FeedbackBug> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedType = 'Feedback';

  final List<Map<String, dynamic>> typeOptions = [
    {'text': 'Feedback', 'icon': Icons.feedback, 'color': Colors.blue},
    {'text': 'Bug', 'icon': Icons.bug_report, 'color': Colors.red},
    {
      'text': 'Feature Request',
      'icon': Icons.new_releases,
      'color': Colors.green
    },
  ];

  void handleSubmit() {
    // Handle form submission logic here
    print('Title: ${titleController.text}');
    print('Description: ${descriptionController.text}');
    print('Type: $selectedType');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Feedback Contact",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      size: 20.sp,
                    ),
                  )
                ],
              ),
              Text(
                "Contact the Feedback here.",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              CustomTextField(
                controller: titleController,
                hintText: 'Enter title',
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.title),
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Enter description',
                textInputType: TextInputType.multiline,
                maxLines: 5,
                prefixIcon: const Icon(Icons.description),
              ),
              SizedBox(height: 2.h),
              CustomDropdown(
                options: typeOptions,
                initialValue: selectedType,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              SizedBox(height: 2.h),
              Container(
                alignment: Alignment.center,
                child: MaterialButton(
                  color: kPrimaryColor,
                  onPressed: () async {
                    try {} catch (e) {}
                  },
                  elevation: 4,
                  child: const Text('Submit Feedback',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }
}
