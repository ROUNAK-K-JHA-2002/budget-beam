import 'package:budgetbeam/models/group_model.dart';
import 'package:budgetbeam/services/group_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupNotifier extends StateNotifier<List<GroupModel>> {
  GroupNotifier() : super([]);

  Future<List<GroupModel>> fetchGroupsByUserId(
      String userId, BuildContext context) async {
    final groups = await getGroupsByUserId(userId, context);
    print(groups);
    state = groups;
    return groups;
  }

  Future<void> updateGroup(
      String groupId, Map<String, dynamic> data, BuildContext context) async {
    await updateGroup(groupId, data, context);
    state = [
      for (final group in state)
        if (group.groupId == groupId) GroupModel.fromJson(data) else group
    ];
  }

  Future<void> deleteGroup(String groupId, BuildContext context) async {
    await deleteGroup(groupId, context);
    state = state.where((group) => group.groupId != groupId).toList();
  }
}

final groupNotifierProvider =
    StateNotifierProvider<GroupNotifier, List<GroupModel>>(
  (ref) => GroupNotifier(),
);
