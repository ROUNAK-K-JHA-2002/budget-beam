import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:budgetbeam/models/user_model.dart'; // Import UserModel

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void updateUser(Map<String, dynamic> updatedData) {
    if (state != null) {
      state = UserModel(
        createdAt: state!.createdAt,
        userId: state!.userId,
        email: updatedData['email'] ?? state!.email,
        dailyLimit: updatedData['daily_limit'] ?? state!.dailyLimit,
        groups: updatedData['groups'] ?? state!.groups,
        hasAllowedGroupFeature: updatedData['has_allowed_group_feature'] ??
            state!.hasAllowedGroupFeature,
        hasOnboarded: updatedData['has_onboarded'] ?? state!.hasOnboarded,
        isConsentUsingApp:
            updatedData['is_consent_using_app'] ?? state!.isConsentUsingApp,
        name: updatedData['name'] ?? state!.name,
        plan: updatedData['plan'] ?? state!.plan,
        profilePhoto: updatedData['profile_photo'] ?? state!.profilePhoto,
        referralCode: updatedData['referral_code'] ?? state!.referralCode,
      );
    }
  }

  void removeUser() {
    state = null;
  }
}

// Provider for UserNotifier
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
