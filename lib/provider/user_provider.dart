import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserState {
  final String? email;
  final String? name;
  final String? profilePhoto;
  final bool? isAnonymous;

  UserState(
      {required this.email,
      required this.name,
      this.profilePhoto,
      this.isAnonymous = false});
}

class UserNotifier extends StateNotifier<UserState?> {
  UserNotifier() : super(null);

  void setUser(UserState user) {
    state = user;
  }

  void removeUser() {
    state = null;
  }
}

// Provider for UserNotifier
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState?>((ref) => UserNotifier());
