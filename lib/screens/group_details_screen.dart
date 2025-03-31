import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GroupDetailsScreen extends StatefulWidget {
  const GroupDetailsScreen({super.key});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Text("Group Details"),
            ],
          ),
        ),
      ),
    );
  }
}
