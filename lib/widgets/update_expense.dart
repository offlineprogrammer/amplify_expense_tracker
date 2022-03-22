import 'package:flutter/material.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class UpdateExpense extends StatefulWidget {
  UpdateExpense(this.expenseItem, this.apiService, {Key? key})
      : super(key: key);

  final APIService apiService;

  final ExpenseItem expenseItem;

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  late ExpenseCategory _selectedExpenseCategory;

  final TextEditingController _editExpenseValueController =
      TextEditingController();

  final TextEditingController _editExpenseNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _editExpenseNameController.text = widget.expenseItem.expensename;
    _editExpenseValueController.text =
        widget.expenseItem.expensevalue.toString();
    _selectedExpenseCategory = widget.expenseItem.expensecategory;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Update Expense here',
        textAlign: TextAlign.center,
      ),
      content: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        child: SingleChildScrollView(
          child: ListBody(children: [
            TextFormField(
              textAlign: TextAlign.center,
              controller: _editExpenseValueController,
              style: const TextStyle(fontSize: 70, color: Colors.black),
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "0.00"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: _editExpenseNameController,
              autofocus: true,
              autocorrect: false,
              decoration: const InputDecoration(hintText: "Expense Name"),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 20.0,
            ),
            FutureBuilder<List<ExpenseCategory?>?>(
                future: widget.apiService.getExpenseCategories(),
                builder: (context, snapshot) {
                  return DropdownButtonFormField<ExpenseCategory>(
                    hint: Text(widget.expenseItem.expensecategory.categoryname),
                    onChanged: (newValue) {
                      _selectedExpenseCategory = newValue!;
                    },
                    // value: selectedCategory,
                    items: snapshot.data
                        ?.map((ec) => DropdownMenuItem<ExpenseCategory>(
                              value: ec,
                              child: Text(ec!.categoryname),
                            ))
                        .toList(),
                  );
                }),
            const SizedBox(
              height: 20.0,
            ),
          ]),
        ),
      ),
      actions: [
        TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final updatedExpenseItem = widget.expenseItem.copyWith(
                expensevalue: double.parse(_editExpenseValueController.text),
                expensename: _editExpenseNameController.text,
                expensecategory: _selectedExpenseCategory,
              );

              await widget.apiService.updateExpense(updatedExpenseItem);

              _editExpenseNameController.clear();
              _editExpenseValueController.clear();
              Navigator.of(context, rootNavigator: true).pop(true);
              //,
            }),
      ],
    );
  }
}
