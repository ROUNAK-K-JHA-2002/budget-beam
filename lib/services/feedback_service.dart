import 'package:budgetbeam/models/feedback_model.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void createFeedback(FeedbackModel feedback, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('feedback')
        .doc()
        .set(feedback.toJson());
    showSuccessSnackbar("Feedback submitted successfully");
  } catch (e) {
    showErrorSnackbar("Failed to submit feedback: $e");
  }
}
