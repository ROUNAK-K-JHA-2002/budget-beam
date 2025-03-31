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
        friends: updatedData['friends'] ?? state!.friends,
        hasOnboarded: updatedData['has_onboarded'] ?? state!.hasOnboarded,
        isConsentUsingApp:
            updatedData['is_consent_using_app'] ?? state!.isConsentUsingApp,
        name: updatedData['name'] ?? state!.name,
        plan: updatedData['plan'] ?? state!.plan,
        profilePhoto: updatedData['profile_photo'] ?? state!.profilePhoto,
        referralCode: updatedData['referral_code'] ?? state!.referralCode,
        subscriptionPurchaseDate: updatedData['subscription_purchase_date'] ??
            state!.subscriptionPurchaseDate,
        subscriptionAmount:
            updatedData['subscription_amount'] ?? state!.subscriptionAmount,
        subscriptionDetails:
            updatedData['subscription_details'] ?? state!.subscriptionDetails,
      );
    }
  }

  void removeUser() {
    state = null;
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserModel?>((ref) => UserNotifier());
