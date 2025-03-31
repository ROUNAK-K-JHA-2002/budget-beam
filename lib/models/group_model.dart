class GroupModel {
  final String groupId;
  final String groupName;
  final String inviteCode;
  final int numberOfMembers;
  final int totalSpendings;
  final DateTime createdAt;
  final bool isPremiumGroup;
  final List<Member> members;
  final List<Transaction> transactions;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.inviteCode,
    required this.numberOfMembers,
    required this.totalSpendings,
    required this.createdAt,
    required this.isPremiumGroup,
    required this.members,
    required this.transactions,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      groupId: json['group_id'],
      groupName: json['group_name'],
      inviteCode: json['invite_code'],
      numberOfMembers: json['number_of_members'],
      totalSpendings: json['total_spendings'],
      createdAt: DateTime.parse(json['created_at']),
      isPremiumGroup: json['is_premium_group'],
      members: (json['members'] as List)
          .map((memberJson) => Member.fromJson(memberJson))
          .toList(),
      transactions: (json['transactions'] as List)
          .map((transactionJson) => Transaction.fromJson(transactionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'group_id': groupId,
      'group_name': groupName,
      'invite_code': inviteCode,
      'number_of_members': numberOfMembers,
      'total_spendings': totalSpendings,
      'created_at': createdAt.toIso8601String(),
      'is_premium_group': isPremiumGroup,
      'members': members.map((member) => member.toJson()).toList(),
      'transactions':
          transactions.map((transaction) => transaction.toJson()).toList(),
    };
  }
}

class Member {
  final String id;
  final String name;
  final String photoUrl;

  Member({
    required this.id,
    required this.name,
    required this.photoUrl,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo_url': photoUrl,
    };
  }
}

class Transaction {
  final String amount;
  final String senderId;
  final String senderName;
  final String senderPhotoUrl;
  final String transactionId;
  final String transactionName;
  final String transactionTag;
  final List<Payable> payables;

  Transaction({
    required this.amount,
    required this.senderId,
    required this.senderName,
    required this.senderPhotoUrl,
    required this.transactionId,
    required this.transactionName,
    required this.transactionTag,
    required this.payables,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      senderPhotoUrl: json['sender_photo_url'],
      transactionId: json['transaction_id'],
      transactionName: json['transaction_name'],
      transactionTag: json['transaction_tag'],
      payables: (json['payables'] as List)
          .map((payableJson) => Payable.fromJson(payableJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'sender_id': senderId,
      'sender_name': senderName,
      'sender_photo_url': senderPhotoUrl,
      'transaction_id': transactionId,
      'transaction_name': transactionName,
      'transaction_tag': transactionTag,
      'payables': payables.map((payable) => payable.toJson()).toList(),
    };
  }
}

class Payable {
  final String amount;
  final String payableId;
  final String payableName;
  final String payablePhotoUrl;

  Payable({
    required this.amount,
    required this.payableId,
    required this.payableName,
    required this.payablePhotoUrl,
  });

  factory Payable.fromJson(Map<String, dynamic> json) {
    return Payable(
      amount: json['amount'],
      payableId: json['payable_id'],
      payableName: json['payable_name'],
      payablePhotoUrl: json['payable_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'payable_id': payableId,
      'payable_name': payableName,
      'payable_photo_url': payablePhotoUrl,
    };
  }
}
