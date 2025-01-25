class FeedbackModel {
  final String description;
  final String email;
  final String title;
  final String type;

  FeedbackModel({
    required this.description,
    required this.email,
    required this.title,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'email': email,
      'title': title,
      'type': type,
    };
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      description: json['description'],
      email: json['email'],
      title: json['title'],
      type: json['type'],
    );
  }
}
