class UserModel {
  final DateTime createdAt;
  final String userId;
  final String email;
  final List<Group> groups;
  final bool hasAllowedGroupFeature;
  final bool hasOnboarded;
  final bool isConsentUsingApp;
  final String name;
  final String profilePhoto;
  final String plan;
  final String dailyLimit;
  final String referralCode;

  UserModel({
    required this.createdAt,
    required this.userId,
    required this.email,
    required this.dailyLimit,
    required this.groups,
    required this.hasAllowedGroupFeature,
    required this.hasOnboarded,
    required this.isConsentUsingApp,
    required this.name,
    required this.plan,
    required this.profilePhoto,
    required this.referralCode,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createdAt: DateTime.parse(json['created_at']),
      email: json['email'],
      dailyLimit: json['daily_limit'],
      userId: json['user_id'],
      groups: (json['groups'] as List)
          .map((groupJson) => Group.fromJson(groupJson))
          .toList(), // Updated to parse groups
      hasAllowedGroupFeature: json['has_allowed_group_feature'],
      hasOnboarded: json['has_onboarded'],
      isConsentUsingApp: json['is_consent_using_app'],
      name: json['name'],
      plan: json['plan'],
      profilePhoto: json['profile_photo'],
      referralCode: json['referral_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'user_id': userId,
      'groups': groups
          .map((group) => group.toJson())
          .toList(), // Updated to serialize groups
      'has_allowed_group_feature': hasAllowedGroupFeature,
      'has_onboarded': hasOnboarded,
      'is_consent_using_app': isConsentUsingApp,
      'name': name,
      'plan': plan,
      'profile_photo': profilePhoto,
      'daily_limit': dailyLimit,
      'referral_code': referralCode,
    };
  }
}

class Group {
  final String id;
  final bool isAdmin;
  final String name;

  Group({
    required this.id,
    required this.isAdmin,
    required this.name,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      isAdmin: json['is_admin'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_admin': isAdmin,
      'name': name,
    };
  }
}
