import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DataAndPrivacy extends StatefulWidget {
  const DataAndPrivacy({super.key});

  @override
  State<DataAndPrivacy> createState() => _DataAndPrivacyState();
}

class _DataAndPrivacyState extends State<DataAndPrivacy> {
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
                    "Data and Privacy",
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
                "Learn about Data and Privacy here.",
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              SizedBox(height: 2.h),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "At BudgetBeam, your privacy is our top priority. Here is how we handle your data:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "1. Data Storage",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "- All your expense tracking data is stored locally on your device.\n"
                      "- We only store user authentication data, such as your Google account information, for logging into the app.",
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "2. Backups",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "- Backups are optional and occur only if you choose to enable them.\n"
                      "- Backup data is stored on your linked Google Drive account and can be restored whenever needed.\n"
                      "- You have full control over enabling or disabling this feature at any time.",
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "3. Data Sharing",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "- BudgetBeam does not share your data with any third-party services.\n"
                      "- Your data remains private and is used solely to provide you with a better expense tracking experience.",
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "4. Security",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "- Your data is securely stored and protected.\n"
                      "- Authentication data is encrypted and managed through Google’s secure systems.",
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "5. Contact Us",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "If you have any questions, concerns, or feedback about our data practices, please reach out to us at:",
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Icon(Icons.email),
                        SizedBox(width: 10),
                        Text(
                          "rounakjha291202.rar@gmail.com",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Understood"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
