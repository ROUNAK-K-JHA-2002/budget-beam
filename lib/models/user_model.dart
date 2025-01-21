class UserModel {
  final DateTime createdAt;
  final String userId;
  final String email;
  final String groupId;
  final String groupName;
  final bool hasAllowedGroupFeature;
  final bool hasOnboarded;
  final bool isConsentUsingApp;
  final String name;
  final String profilePhoto;
  final String plan;

  UserModel({
    required this.createdAt,
    required this.userId,
    required this.email,
    required this.groupId,
    required this.groupName,
    required this.hasAllowedGroupFeature,
    required this.hasOnboarded,
    required this.isConsentUsingApp,
    required this.name,
    required this.plan,
    required this.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createdAt: DateTime.parse(json['created_at']),
      email: json['email'],
      userId: json['user_id'],
      groupId: json['group_id'],
      groupName: json['group_name'],
      hasAllowedGroupFeature: json['has_allowed_group_feature'],
      hasOnboarded: json['has_onboarded'],
      isConsentUsingApp: json['is_consent_using_app'],
      name: json['name'],
      plan: json['plan'],
      profilePhoto: json['profile_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'group_id': groupId,
      'user_id': userId,
      'group_name': groupName,
      'has_allowed_group_feature': hasAllowedGroupFeature,
      'has_onboarded': hasOnboarded,
      'is_consent_using_app': isConsentUsingApp,
      'name': name,
      'plan': plan,
      'profile_photo': profilePhoto,
    };
  }
}
