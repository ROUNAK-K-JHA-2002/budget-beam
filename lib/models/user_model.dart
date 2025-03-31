class UserModel {
  final DateTime createdAt;
  final String userId;
  final String email;
  final List<Group> groups;
  final List<Friend> friends;
  final bool hasOnboarded;
  final bool isConsentUsingApp;
  final String name;
  final String profilePhoto;
  final String plan;
  final String dailyLimit;
  final String referralCode;
  final DateTime? subscriptionPurchaseDate;
  final double? subscriptionAmount;
  final String? subscriptionDetails;

  UserModel({
    required this.createdAt,
    required this.userId,
    required this.email,
    required this.dailyLimit,
    required this.groups,
    required this.friends,
    required this.hasOnboarded,
    required this.isConsentUsingApp,
    required this.name,
    required this.plan,
    required this.profilePhoto,
    required this.referralCode,
    required this.subscriptionPurchaseDate,
    required this.subscriptionAmount,
    required this.subscriptionDetails,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      createdAt: DateTime.parse(json['created_at']),
      email: json['email'],
      dailyLimit: json['daily_limit'],
      userId: json['user_id'],
      groups: (json['groups'] as List)
          .map((groupJson) => Group.fromJson(groupJson))
          .toList(),
      friends: (json['friends'] as List)
          .map((friendJson) => Friend.fromJson(friendJson))
          .toList(),
      hasOnboarded: json['has_onboarded'],
      isConsentUsingApp: json['is_consent_using_app'],
      name: json['name'],
      plan: json['plan'],
      profilePhoto: json['profile_photo'],
      referralCode: json['referral_code'],
      subscriptionPurchaseDate: json['subscription_purchase_date'] != null
          ? DateTime.parse(json['subscription_purchase_date'])
          : null,
      subscriptionAmount: json['subscription_amount']?.toDouble(),
      subscriptionDetails: json['subscription_details'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'email': email,
      'user_id': userId,
      'groups': groups.map((group) => group.toJson()).toList(),
      'friends': friends.map((friend) => friend.toJson()).toList(),
      'has_onboarded': hasOnboarded,
      'is_consent_using_app': isConsentUsingApp,
      'name': name,
      'plan': plan,
      'profile_photo': profilePhoto,
      'daily_limit': dailyLimit,
      'referral_code': referralCode,
      'subscription_purchase_date': subscriptionPurchaseDate,
      'subscription_amount': subscriptionAmount,
      'subscription_details': subscriptionDetails,
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

class Friend {
  final String name;
  final String email;
  final String profilePicture;

  Friend({
    required this.name,
    required this.email,
    required this.profilePicture,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
    };
  }
}

class FriendRequest {
  final String name;
  final String email;
  final String profilePicture;
  final String userId;
  final String status;
  final DateTime createdAt;
  final String recieverEmail;

  FriendRequest({
    required this.name,
    required this.email,
    required this.profilePicture,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.recieverEmail,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      userId: json['user_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      recieverEmail: json['reciever_email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
      'user_id': userId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'reciever_email': recieverEmail,
    };
  }
}
