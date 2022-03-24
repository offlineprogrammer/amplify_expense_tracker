import 'package:amplify_expense_tracker/services/api_service.dart';
import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';

class DeleteExpense extends StatefulWidget {
  const DeleteExpense(this.expenseItem, this.apiService, {Key? key})
      : super(key: key);
  final ExpenseItem expenseItem;
  final APIService apiService;

  @override
  State<DeleteExpense> createState() => _DeleteExpenseState();
}

class _DeleteExpenseState extends State<DeleteExpense> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Delete this expense?'),
      actions: [
        TextButton(
            onPressed: () async {
              await widget.apiService.deleteExpense(widget.expenseItem);
              Navigator.of(context).pop(true);
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'))
      ],
    );
  }
}
