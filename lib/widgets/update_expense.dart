import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class UpdateExpense extends StatefulWidget {
  const UpdateExpense(this.expenseItem, this.apiService, {Key? key})
      : super(key: key);

  final APIService apiService;

  final ExpenseItem expenseItem;

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  ExpenseCategory? _selectedExpenseCategory;
  final TextEditingController _editExpenseValueController =
      TextEditingController();
  final TextEditingController _editExpenseNameController =
      TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setEditExpenseItems();
  }

  void _setEditExpenseItems() {
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
      content: Form(
        key: formGlobalKey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _editExpenseValueController,
                  style: const TextStyle(fontSize: 70, color: Colors.black),
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "0.00"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    const _validationError = 'Enter a valid expense value';
                    if (value == null || value.isEmpty) {
                      return _validationError;
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return _validationError;
                    }
                    return null;
                  },
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
                  validator: (name) {
                    if (name != null && name.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter a valid expense name';
                    }
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FutureBuilder<List<ExpenseCategory?>?>(
                    future: widget.apiService.getExpenseCategories(),
                    builder: (context, snapshot) {
                      return DropdownButtonFormField<ExpenseCategory>(
                        hint: Text(
                            widget.expenseItem.expensecategory.categoryname),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedExpenseCategory = newValue!;
                          });
                        },
                        value: _selectedExpenseCategory,
                        validator: (selected) {
                          if (selected == null) {
                            return 'Select a Category';
                          }
                          return null;
                        },
                        items: snapshot.data
                            ?.whereType<ExpenseCategory>()
                            .map((ec) => DropdownMenuItem<ExpenseCategory>(
                                  value: ec,
                                  child: Text(ec.categoryname),
                                ))
                            .toList(),
                      );
                    }),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
            child: const Text('Save'),
            onPressed: () async {
              final currentState = formGlobalKey.currentState;
              if (currentState == null) {
                return;
              }
              if (currentState.validate()) {
                ExpenseItem _updatedExpenseItem = widget.expenseItem.copyWith(
                    expensevalue:
                        double.parse(_editExpenseValueController.text),
                    expensename: _editExpenseNameController.text,
                    expensecategory: _selectedExpenseCategory);
                Navigator.of(context).pop(_updatedExpenseItem);
              }

              //,
            }),
      ],
    );
  }
}
