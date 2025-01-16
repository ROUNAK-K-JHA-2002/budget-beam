import 'package:budgetbeam/entity/expense_entity.dart';
import 'package:budgetbeam/objectbox.g.dart';
import 'package:budgetbeam/services/object_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseProvider = StreamProvider<List<ExpenseEntity>>((ref) {
  // Access the singleton instance of ObjectBoxStore
  final box = ObjectBoxStore.instance.store.box<ExpenseEntity>();

  // Build a query and watch for changes
  final query = box
      .query(
          ExpenseEntity_.userId.equals(FirebaseAuth.instance.currentUser!.uid))
      .watch(triggerImmediately: true);

  // Map the query result to a List<ExpenseEntity>
  return query.map((query) => query.find());
});
