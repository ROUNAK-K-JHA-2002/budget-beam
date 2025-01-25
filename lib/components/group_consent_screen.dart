// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/main.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupScreen extends ConsumerWidget {
  const GroupScreen({super.key});

  void _showConsentModal(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents closing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Consent for Data Sync"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "We want to be transparent with you about how your data is handled:",
              ),
              SizedBox(height: 10),
              Text(
                "1. Group Data Sync: Any data related to group transactions, such as expenses or group activities, will be securely synced to the server for easy collaboration with your group members. This ensures everyone stays updated.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "2. Personal Data Privacy: Your personal expenses and data are stored locally on your device, ensuring your privacy. No personal data is sent to the server. We do not store or share any personal financial information without your consent.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "By continuing, you agree to these terms and acknowledge that your group-related data will be synced for collaborative purposes, while your personal data remains private and local.",
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when user agrees
                Navigator.of(context).pop();
              },
              child: const Text("I don't want to sync"),
            ),
            TextButton(
              onPressed: () {
                // Close the dialog when user agrees
                Navigator.of(context).pop();
              },
              child: const Text("I Agree"),
            ),
          ],
        );
      },
    );
  }

  void _checkConsent(BuildContext context, WidgetRef ref) async {
    final hasSeenConsentPopup =
        await storage.read(key: "has_seen_consent_popup");

    final hasAllowedGroupFeature =
        ref.read(userNotifierProvider)!.hasAllowedGroupFeature;
    if (!hasAllowedGroupFeature && hasSeenConsentPopup != "true") {
      _showConsentModal(context, ref);
      storage.write(key: "has_seen_consent_popup", value: "true");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasAllowedGroupFeature =
        ref.read(userNotifierProvider)!.hasAllowedGroupFeature;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkConsent(context, ref);
    });

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.group,
              size: 40.sp,
              color: kPrimaryColor,
            ),
            Text(
              "Welcome to Groups!",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.5.h),
            Text(
              "Start managing your shared expenses with friends.",
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.5.h),
            Text(
              "Your personal expenses are not synced with the servers and are stored locally on your device for privacy. You have the option to back them up to your google drive.",
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              "Group transactions are synced with the servers to keep all members updated and ensure smooth collaboration.",
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            SizedBox(height: 2.h),
            if (!hasAllowedGroupFeature) ...[
              const Text(
                "You have not allowed group chat features.",
                style: TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.5.h),
              ElevatedButton(
                onPressed: () {
                  _showConsentModal(context, ref);
                },
                child: const Text("Allow Consent to Sync Data"),
              ),
              SizedBox(height: 2.h),
              Text(
                "Your Private expenses are not synced with the servers and are stored locally on your device for privacy.",
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ] else ...[
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to Create Group Screen
                },
                icon: const Icon(Icons.group_add),
                label: const Text("Create Group"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 2.h),

              // Join Group Button
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to Join Group Screen
                },
                icon: const Icon(Icons.group),
                label: const Text("Join Group"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                  side: const BorderSide(color: Colors.teal, width: 2),
                ),
              ),
            ]
          ],
        ),
      ),
    ));
  }
}
