import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budgetbeam/models/user_model.dart'; // Import UserModel

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void removeUser() {
    state = null;
  }
}

// Provider for UserNotifier
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
