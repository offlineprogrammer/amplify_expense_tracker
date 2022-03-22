import 'package:amplify_expense_tracker/services/api_service.dart';
import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';

class DeleteExpense extends StatelessWidget {
  const DeleteExpense(this.expenseItem, this.apiService, {Key? key})
      : super(key: key);
  final ExpenseItem expenseItem;
  final APIService apiService;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Delete this expense?'),
      actions: [
        // The "Yes" button
        TextButton(
          onPressed: () async {
            await apiService.deleteExpense(expenseItem);

            Navigator.of(context).pop(true);
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        )
      ],
    );
  }
}
