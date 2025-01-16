class GroupModel {
  final String groupId;
  final String groupName;
  final String inviteCode;
  final int numberOfMembers;
  final int totalSpendings;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.inviteCode,
    required this.numberOfMembers,
    required this.totalSpendings,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['group_id'],
      groupName: json['group_name'],
      inviteCode: json['invite_code'],
      numberOfMembers: json['number_of_members'],
      totalSpendings: json['total_spendings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'invite_code': inviteCode,
      'number_of_members': numberOfMembers,
      'total_spendings': totalSpendings,
    };
  }
}
