import 'package:budgetbeam/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'Groups',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
