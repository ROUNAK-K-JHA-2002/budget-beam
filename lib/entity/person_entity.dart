import 'package:objectbox/objectbox.dart';

@Entity()
class PersonEntity {
  @Id()
  int id;
  String name;
  String email;
  DateTime dateCreated;
  bool hasCompletedOnboarding;

  PersonEntity({
    this.id = 0,
    required this.name,
    required this.email,
    required this.dateCreated,
    required this.hasCompletedOnboarding,
  });
}
