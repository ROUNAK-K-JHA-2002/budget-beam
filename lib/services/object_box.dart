import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:budgetbeam/entity/person_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../objectbox.g.dart';

class ObjectBoxStore {
  late final Store store;
  late final Box<PersonEntity> personBox;
  late final Box<ExpenseEntity> expenseBox;
  static ObjectBoxStore? _instance;

  ObjectBoxStore._create(this.store) {
    _instance = this;
    expenseBox = Box<ExpenseEntity>(store);
    personBox = Box<PersonEntity>(store);
  }

  static ObjectBoxStore get instance {
    if (_instance == null) {
      throw Exception(
          "ObjectBoxStore not initialized. Call ObjectBoxStore.create() first.");
    }
    return _instance!;
  }

  static Future<ObjectBoxStore> create() async {
    final store = await openStore();
    return ObjectBoxStore._create(store);
  }

  int saveExpenseToDB(int id, String name, int amount, DateTime date,
      String category, String type, bool isUpdate) {
    final box = store.box<ExpenseEntity>();
    final expense = ExpenseEntity(
        id: isUpdate ? id : 0,
        name: name,
        amount: amount,
        dateCreated: date,
        dateUpdated: date,
        category: category,
        type: type,
        userId: FirebaseAuth.instance.currentUser!.uid);
    return box.put(expense, mode: isUpdate ? PutMode.update : PutMode.insert);
  }

  bool deleteExpenseFromDB(int id) {
    return expenseBox.remove(id);
  }
}
