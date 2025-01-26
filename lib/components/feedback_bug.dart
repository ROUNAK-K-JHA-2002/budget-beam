import 'package:budgetbeam/components/dropdown.dart';
import 'package:budgetbeam/components/text_field.dart';
import 'package:budgetbeam/models/feedback_model.dart';
import 'package:budgetbeam/services/feedback_service.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FeedbackBug extends StatefulWidget {
  final String email;
  const FeedbackBug({super.key, required this.email});

  @override
  State<FeedbackBug> createState() => _FeedbackBugState();
}

class _FeedbackBugState extends State<FeedbackBug> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedType = 'Feedback';
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  final List<Map<String, dynamic>> typeOptions = [
    {'text': 'Feedback', 'icon': Icons.feedback, 'color': Colors.blue},
    {'text': 'Bug', 'icon': Icons.bug_report, 'color': Colors.red},
    {
      'text': 'Feature Request',
      'icon': Icons.new_releases,
      'color': Colors.green
    },
  ];

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
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 16.sp,
                      // color: Colors.black,
                    ),
                  ),
                  const Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                controller: titleController,
                hintText: 'Enter title',
                textInputType: TextInputType.text,
                prefixIcon: const Icon(Icons.title),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 16.sp,
                      // color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                controller: descriptionController,
                hintText: 'Enter description',
                textInputType: TextInputType.multiline,
                maxLines: 3,
                prefixIcon: const Icon(Icons.description),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Text(
                    "Feedback Type",
                    style: TextStyle(
                      fontSize: 16.sp,
                      // color: Colors.black,
                    ),
                  ),
                  const Text("*", style: TextStyle(color: Colors.red)),
                ],
              ),
              SizedBox(height: 1.h),
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
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (context, value, child) {
                  return Container(
                    alignment: Alignment.center,
                    child: MaterialButton(
                      disabledColor: kPrimaryColor.withOpacity(0.5),
                      color: kPrimaryColor,
                      enableFeedback: false,
                      onPressed: () async {
                        isLoading.value = true;

                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          isLoading.value = false;
                          showErrorSnackbar(
                              "Please fill all the required fields");
                          return;
                        }

                        createFeedback(
                            FeedbackModel(
                                email: widget.email,
                                title: titleController.text,
                                description: descriptionController.text,
                                type: selectedType),
                            context);

                        Future.delayed(const Duration(seconds: 1), () {
                          isLoading.value = false;
                          Navigator.pop(context);
                        });
                      },
                      elevation: 4,
                      child: value
                          ? LoadingAnimationWidget.waveDots(
                              color: Colors.white, size: 15.sp)
                          : const Text('Submit Feedback',
                              style: TextStyle(color: Colors.white)),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
