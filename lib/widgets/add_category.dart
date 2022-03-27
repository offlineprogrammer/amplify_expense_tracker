import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory(this.apiService, {Key? key}) : super(key: key);

  final APIService apiService;

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController _expenseCategoryController =
      TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Add Category here',
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formGlobalKey,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                    controller: _expenseCategoryController,
                    autofocus: true,
                    autocorrect: false,
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return 'Enter a valid category';
                      }
                      return null;
                    },
                    decoration:
                        const InputDecoration(hintText: "Category Name"),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      Navigator.of(context)
                          .pop(_expenseCategoryController.text);
                    } //,
                    ),
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
            child: const Text('OK'),
            onPressed: () {
              final currentState = formGlobalKey.currentState;
              if (currentState == null) {
                return;
              }
              if (currentState.validate()) {
                currentState.save();
                Navigator.of(context).pop(_expenseCategoryController.text);
              }
            } //,, //,
            ),
      ],
    );
  }
}
