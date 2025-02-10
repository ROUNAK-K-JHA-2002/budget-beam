// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void createUser(UserModel user, BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .set(user.toJson());
    showSuccessSnackbar("User created successfully");
    ref.read(userNotifierProvider.notifier).setUser(user);
  } catch (e) {
    showErrorSnackbar("Failed to create user: $e");
  }
}

void updateUser(String userId, Map<String, dynamic> userData,
    BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(userData);
    showSuccessSnackbar("User updated successfully");
    ref.read(userNotifierProvider.notifier).updateUser(userData);
  } catch (e) {
    showErrorSnackbar("Failed to update user: $e");
  }
}

Future<UserModel?> getUser(
    String userId, BuildContext context, WidgetRef ref) async {
  try {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (doc.exists) {
      UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);

      ref.read(userNotifierProvider.notifier).setUser(user);
      return user;
    } else {
      return null;
    }
  } catch (e) {
    showErrorSnackbar("Failed to retrieve user: $e");
    return null;
  }
}
