import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/ModelProvider.dart';
import '../services/api_service.dart';

class AddExpense extends StatelessWidget {
  AddExpense(this.apiService, {Key? key}) : super(key: key);

  final APIService apiService;

  final TextEditingController _expenseValueController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();

  ExpenseCategory? _selectedExpenseCategory;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Expense here',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formGlobalKey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: ListBody(children: [
              TextFormField(
                textAlign: TextAlign.center,
                controller: _expenseValueController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  const _validationError = 'Enter a valid expense value';
                  if (value!.isEmpty) {
                    return _validationError;
                  }
                  if (double.parse(value) <= 0) {
                    return _validationError;
                  }
                  return null;
                },
                style: const TextStyle(fontSize: 70, color: Colors.black),
                autofocus: true,
                autocorrect: false,
                decoration: const InputDecoration(hintText: "0.00"),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _expenseNameController,
                autofocus: true,
                autocorrect: false,
                decoration: const InputDecoration(hintText: "Expense Name"),
                textInputAction: TextInputAction.done,
                validator: (name) {
                  if (name!.isNotEmpty) {
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
                  future: apiService.getExpenseCategories(),
                  builder: (context, snapshot) {
                    return DropdownButtonFormField<ExpenseCategory>(
                      hint: const Text("Select"),
                      value: _selectedExpenseCategory,
                      onChanged: (newValue) {
                        _selectedExpenseCategory = newValue;
                      },
                      validator: (selected) {
                        if (selected == null) {
                          return 'Select an expense item';
                        }
                        return null;
                      },
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
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () async {
            if (formGlobalKey.currentState!.validate()) {
              formGlobalKey.currentState!.save();
              ExpenseItem expenseItem = ExpenseItem(
                expensename: _expenseNameController.text,
                expensevalue: double.parse(_expenseValueController.text),
                createdAt: TemporalDateTime.now(),
                expensecategory: _selectedExpenseCategory!,
              );

              await apiService.saveExpense(expenseItem);

              _expenseNameController.clear();
              _expenseValueController.clear();
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
    );
  }
}
