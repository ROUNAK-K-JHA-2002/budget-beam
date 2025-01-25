import 'package:budgetbeam/models/feedback_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void createUser(FeedbackModel feedback, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('feedback')
        .doc(feedback.email)
        .set(feedback.toJson());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback submitted successfully')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to create user: $e')),
    );
  }
}
