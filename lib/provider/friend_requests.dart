import 'package:budgetbeam/models/user_model.dart';
import 'package:budgetbeam/services/group_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendRequestsNotifier extends StateNotifier<List<FriendRequest>> {
  FriendRequestsNotifier() : super([]);

  Future<List<FriendRequest>> fetchFriendRequests(
      String userEmail, BuildContext context) async {
    final friendRequests = await getFriendRequests(userEmail, context);
    state = friendRequests;
    return friendRequests;
  }
}

final friendRequestsNotifierProvider =
    StateNotifierProvider<FriendRequestsNotifier, List<FriendRequest>>(
        (ref) => FriendRequestsNotifier());
