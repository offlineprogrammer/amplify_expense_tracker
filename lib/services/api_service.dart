import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/ModelProvider.dart';

class APIService {
  Future<List<ExpenseItem?>?> getExpenses() async {
    try {
      final request = ModelQueries.list(ExpenseItem.classType);
      final response = await Amplify.API.query(request: request).response;
      List<ExpenseItem?>? expenseItems = response.data?.items;
      expenseItems?.sort((a, b) => b!.createdAt.compareTo(a!.createdAt));
      return expenseItems;
    } on Exception catch (e) {
      _showError(e);
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
    } on Exception catch (e) {
      _showError(e);
    }
  }

  Future<void> updateExpense(ExpenseItem updatedExpenseItem) async {
    try {
      final request = ModelMutations.update(updatedExpenseItem);
      final response = await Amplify.API.mutate(request: request).response;
    } on Exception catch (e) {
      _showError(e);
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
    } on Exception catch (e) {
      _showError(e);
    }
  }

  Future<List<ExpenseCategory?>?> getExpenseCategories() async {
    try {
      final request = ModelQueries.list(ExpenseCategory.classType);
      final response = await Amplify.API.query(request: request).response;
      List<ExpenseCategory?>? expenseCategories = response.data?.items;
      return expenseCategories;
    } on Exception catch (e) {
      _showError(e);
    }
    return null;
  }

  Future<void> deleteExpense(ExpenseItem expenseItem) async {
    try {
      final request = ModelMutations.delete(expenseItem);
      final response = await Amplify.API.mutate(request: request).response;
    } on Exception catch (e) {
      _showError(e);
    }
  }

  void _showError(Exception e) {
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(e.toString()),
    ));
  }
}
