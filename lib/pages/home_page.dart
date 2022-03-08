import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/ModelProvider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ExpenseItem?>?> expenseItems;

  Future<List<ExpenseItem?>?> _getExpenses() async {
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

  @override
  void initState() {
    super.initState();
    expenseItems = _getExpenses();
  }

  final TextEditingController _expenseCategoryController =
      TextEditingController();
  final TextEditingController _expenseValueController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();
  late ExpenseCategory _selectedExpenseCategory;

  Future<void> _saveCategory() async {
    try {
      ExpenseCategory expenseCategory = ExpenseCategory(
        categoryname: _expenseCategoryController.text,
      );
      final request = ModelMutations.create(expenseCategory);
      final response = await Amplify.API.mutate(request: request).response;

      ExpenseCategory? createdExpenseCategory = response.data;
      if (createdExpenseCategory == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> _deleteExpenseItem(ExpenseItem expenseItem) async {
    try {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Delete this expense?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () async {
                    // Remove the box
                    print('Delete');
                    final request = ModelMutations.delete(expenseItem);
                    final response =
                        await Amplify.API.mutate(request: request).response;

                    setState(() {
                      expenseItems = _getExpenses();
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        },
      );
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> _saveExpense() async {
    try {
      ExpenseItem expenseItem = ExpenseItem(
        expensename: _expenseNameController.text,
        expensevalue: double.parse(_expenseValueController.text),
        createdAt: TemporalDateTime.now(),
        expensecategory: _selectedExpenseCategory,
      );
      final request = ModelMutations.create(expenseItem);
      final response = await Amplify.API.mutate(request: request).response;

      ExpenseItem? createdExpenseItem = response.data;
      if (createdExpenseItem == null) {
        print('errors: ' + response.errors.toString());
        return;
      }
      print('Mutation result: ' + createdExpenseItem.expensename);

      setState(() {
        expenseItems = _getExpenses();
      });
      _expenseNameController.clear();
      _expenseValueController.clear();
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<List<ExpenseCategory?>?> _getExpenseCategories() async {
    try {
      final request = ModelQueries.list(ExpenseCategory.classType);
      final response = await Amplify.API.query(request: request).response;
      List<ExpenseCategory?>? expenseCategories = response.data?.items;
      return expenseCategories;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return null;
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Expense here',
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ListBody(children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: _expenseValueController,
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
                  controller: _expenseNameController,
                  autofocus: true,
                  autocorrect: false,
                  decoration: const InputDecoration(hintText: "Expense Name"),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FutureBuilder<List<ExpenseCategory?>?>(
                    future: _getExpenseCategories(),
                    builder: (context, snapshot) {
                      return DropdownButtonFormField<ExpenseCategory>(
                        hint: const Text("Select"),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedExpenseCategory = newValue!;
                          });
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
              child: const Text('OK'),
              onPressed: _saveExpense, //,
            ),
          ],
        );
        ;
      },
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Category here',
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.all(16.0),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                    controller: _expenseCategoryController,
                    autofocus: true,
                    autocorrect: false,
                    decoration:
                        const InputDecoration(hintText: "Category Name"),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _saveCategory(),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: _saveCategory, //,
            ),
          ],
        );
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: expensesWidget(),
      floatingActionButton: SpeedDial(icon: Icons.add, children: [
        SpeedDialChild(
          child: const Icon(Icons.attach_money),
          label: 'Add Expense',
          backgroundColor: Colors.blue,
          onTap: () {
            _showAddExpenseDialog(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.file_copy),
          label: 'Add Category',
          backgroundColor: Colors.blue,
          onTap: () {
            _showAddCategoryDialog(context);
          },
        ),
      ]),
    );
  }

  Widget expensesWidget() {
    return FutureBuilder<List<ExpenseItem?>?>(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.amber,
              child: const ListTile(
                leading: Text(''),
                title: Text('Expense'),
                trailing: Text('Value'),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.delete,
                          color: Colors.red, size: 30.0),
                      onPressed: () {
                        print('ok');
                        _deleteExpenseItem(snapshot.data![index]!);
                      },
                    ),
                    title: Text(snapshot.data![index]!.expensename),
                    subtitle: Text(
                        snapshot.data![index]!.expensecategory.categoryname),
                    trailing: Text(
                        '\$${snapshot.data![index]!.expensevalue.toString()}'),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    indent: 20,
                    endIndent: 20,
                  );
                },
              ),
            ),
          ],
        );
      },
      future: expenseItems,
    );
  }
}
