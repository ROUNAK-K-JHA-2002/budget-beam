// ignore_for_file: use_build_context_synchronously

import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/provider/user_provider.dart';
import 'package:budgetbeam/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void createUser(UserModel user, BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.userId)
        .set(user.toJson());
    showSuccessSnackbar("Welcome to Budget Beam");
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    for (var doc in querySnapshot.docs) {
      List<dynamic> friends = doc['friends'];
      bool isFriendUpdated = false;
      for (var friend in friends) {
        if (friend['email'] == user.email) {
          friend['profilePhoto'] = user.profilePhoto;
          friend['isOnboarded'] = user.hasOnboarded;
          isFriendUpdated = true;
        }
      }
      if (isFriendUpdated) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(doc.id)
            .update({'friends': friends});
      }
    }

    for (var doc in querySnapshot.docs) {
      if (doc['email'] != user.email) {
        List<dynamic> friends = doc['friends'];
        bool isUserInFriendsList =
            friends.any((friend) => friend['email'] == user.email);
        if (isUserInFriendsList) {
          friends.add({
            'email': doc['email'],
            'name': doc['name'],
            'profilePhoto': doc['profilePhoto'],
            'isOnboarded': doc['isOnboarded'],
          });
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.userId)
              .update({'friends': friends});
        }
      }
    }
    ref.read(userNotifierProvider.notifier).setUser(user);
  } catch (e) {
    showErrorSnackbar("Failed to create user: $e");
  }
}

Future<void> updateUser(String userId, Map<String, dynamic> userData,
    BuildContext context, WidgetRef ref) async {
  try {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(userData);
    getUser(context, ref);
  } catch (e) {
    showErrorSnackbar("Failed to update user: $e");
  }
}

Future<UserModel?> getUser(BuildContext context, WidgetRef ref) async {
  try {
    var userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (doc.exists) {
        ref
            .read(userNotifierProvider.notifier)
            .setUser(UserModel.fromJson(doc.data() as Map<String, dynamic>));
        UserModel user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
        return user;
      } else {
        return null;
      }
    } else
      return null;
  } catch (e) {
    return null;
  }
}

Future<UserModel?> getUserByEmail(String email, BuildContext context) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      return UserModel.fromJson(doc.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<void> addFriends(
    String userId, Friend friend, BuildContext context) async {
  try {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('friends').doc(userId);
    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      await docRef.update({
        'friends': FieldValue.arrayUnion([friend.toJson()])
      });
    } else {
      await FirebaseFirestore.instance.collection('friends').doc(userId).set({
        'user_id': userId,
        'friends': [friend.toJson()]
      });
    }
  } catch (e) {
    showErrorSnackbar("Failed to add friend: $e");
  }
}

Future<bool> sendFriendRequest(
    FriendRequest friendRequest, BuildContext context) async {
  try {
    await FirebaseFirestore.instance
        .collection('friend_requests')
        .doc()
        .set(friendRequest.toJson());
    showSuccessSnackbar("Friend request sent");
    return true;
  } catch (e) {
    showErrorSnackbar("Failed to send friend request: $e");
    return false;
  }
}
