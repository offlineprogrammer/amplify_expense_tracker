import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_expense_tracker/main.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/ModelProvider.dart';

class APIService {
  Future<List<ExpenseItem?>?> getExpenses() async {
    try {
      final request = ModelQueries.list(ExpenseItem.classType);
      final response = await Amplify.API.query(request: request).response;
      List<ExpenseItem?>? expenseItems = response.data?.items;
      expenseItems!.sort((a, b) => b!.createdAt.compareTo(a!.createdAt));
      return expenseItems;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return null;
  }

  Future<void> saveCategory(String categoryname) async {
    try {
      ExpenseCategory expenseCategory = ExpenseCategory(
        categoryname: categoryname,
      );
      final request = ModelMutations.create(expenseCategory);
      final response = await Amplify.API.mutate(request: request).response;

      ExpenseCategory? createdExpenseCategory = response.data;
      if (createdExpenseCategory == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> updateExpense(ExpenseItem updatedExpenseItem) async {
    try {
      final request = ModelMutations.update(updatedExpenseItem);
      final response = await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> saveExpense(ExpenseItem expenseItem) async {
    try {
      final request = ModelMutations.create(expenseItem);
      final response = await Amplify.API.mutate(request: request).response;

      ExpenseItem? createdExpenseItem = response.data;
      if (createdExpenseItem == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Mutation result: ' + createdExpenseItem.expensename);
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<List<ExpenseCategory?>?> getExpenseCategories() async {
    try {
      final request = ModelQueries.list(ExpenseCategory.classType);
      final response = await Amplify.API.query(request: request).response;
      List<ExpenseCategory?>? expenseCategories = response.data?.items;
      return expenseCategories;
    } on ApiException catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(snackBar)
    }
    return null;
  }

  Future<void> deleteExpense(ExpenseItem expenseItem) async {
    try {
      final request = ModelMutations.delete(expenseItem);
      final response = await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }
}
