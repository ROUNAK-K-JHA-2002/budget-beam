import 'package:budgetbeam/models/group_model.dart';
import 'package:budgetbeam/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void createGroup(GroupModel group, BuildContext context) {
  try {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('groups').doc();
    docRef.set(group.toJson()).then((_) {
      docRef.update({'group_id': docRef.id});
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error creating group: $e')),
    );
  }
}

void updateGroup(
    String groupId, Map<String, dynamic> data, BuildContext context) {
  try {
    FirebaseFirestore.instance.collection('groups').doc(groupId).update(data);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error updating group: $e')),
    );
  }
}

Future<GroupModel?> getGroup(String groupId, BuildContext context) async {
  try {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .get();
    if (doc.exists) {
      return GroupModel.fromJson(doc.data() as Map<String, dynamic>);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error getting group: $e')),
    );
  }
  return null;
}

void deleteGroup(String groupId, BuildContext context) {
  try {
    FirebaseFirestore.instance.collection('groups').doc(groupId).delete();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error deleting group: $e')),
    );
  }
}

Future<List<FriendRequest>> getFriendRequests(
    String userEmail, BuildContext context) async {
  try {
    print("userEmail: $userEmail");
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('reciever_email', isEqualTo: userEmail)
        .get();
    print("querySnapshot: $querySnapshot");
    return querySnapshot.docs
        .map(
            (doc) => FriendRequest.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error getting friend requests: $e')),
    );
    return [];
  }
}
