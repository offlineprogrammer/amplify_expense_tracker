import 'package:flutter/material.dart';

class DeleteExpense extends StatefulWidget {
  const DeleteExpense({Key? key}) : super(key: key);

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
