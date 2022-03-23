import 'package:flutter/material.dart';

import '../services/api_service.dart';

class AddCategory extends StatelessWidget {
  AddCategory(this.apiService, {Key? key}) : super(key: key);

  final APIService apiService;

  final TextEditingController _expenseCategoryController =
      TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  Future<void> _saveCategory(BuildContext context) async {
    await apiService.saveCategory(_expenseCategoryController.text);
    _expenseCategoryController.text = '';
    Navigator.of(context, rootNavigator: true).pop(true);
  }

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
                      if (name!.isNotEmpty) {
                        return null;
                      } else {
                        return 'Enter a valid category';
                      }
                    },
                    decoration:
                        const InputDecoration(hintText: "Category Name"),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      _saveCategory(context);
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
              if (formGlobalKey.currentState!.validate()) {
                formGlobalKey.currentState!.save();
                _saveCategory(context);
              }
            } //,, //,
            ),
      ],
    );
  }
}
