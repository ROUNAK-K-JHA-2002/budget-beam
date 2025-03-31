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

Future<List<GroupModel>> getGroupsByUserId(
    String userId, BuildContext context) async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('groups').get();

    List<GroupModel> groups = querySnapshot.docs
        .map((doc) => GroupModel.fromJson(doc.data() as Map<String, dynamic>))
        .where((group) => group.members.any((member) => member.id == userId))
        .toList();

    return groups;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching groups: $e')),
    );
    return [];
  }
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
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friend_requests')
        .where('reciever_email', isEqualTo: userEmail)
        .get();
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
