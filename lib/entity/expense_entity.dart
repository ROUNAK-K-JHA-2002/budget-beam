import 'package:objectbox/objectbox.dart';

@Entity()
class ExpenseEntity {
  @Id()
  int id;
  String name;
  int amount;
  DateTime dateCreated;
  DateTime dateUpdated;
  String category;
  String type;
  String userId;

  ExpenseEntity({
    this.id = 0,
    required this.name,
    required this.amount,
    required this.dateCreated,
    required this.dateUpdated,
    required this.category,
    required this.type,
    required this.userId,
  });
}
