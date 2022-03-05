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
      print('Start');
      final request = ModelQueries.list(ExpenseItem.classType);
      print('1');
      final response = await Amplify.API.query(request: request).response;
      print('2');
      List<ExpenseItem?>? expenseItems = response.data?.items;
      print(expenseItems!.length);
      print(expenseItems);
      expenseItems.sort((a, b) => b!.createdAt.compareTo(a!.createdAt));
      print(expenseItems);
      return expenseItems; //.reversed.toList();
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
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
      print('Mutation result: ' + createdExpenseCategory.categoryname);
      Navigator.of(context, rootNavigator: true).pop('dialog');
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
        type: 'expenseItem',
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

  Future<void> _submit() async {}

  Future<List<ExpenseCategory?>?> _getExpenseCategories() async {
    try {
      print('0');
      final request = ModelQueries.list(ExpenseCategory.classType);
      print('00');
      final response = await Amplify.API.query(request: request).response;
      print('000');
      List<ExpenseCategory?>? expenseCategories = response.data?.items;
      return expenseCategories;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
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
                  onEditingComplete: () => _submit(),
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
                  onEditingComplete: () => _submit(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FutureBuilder<List<ExpenseCategory?>?>(
                    future: _getExpenseCategories(),
                    builder: (context, snapshot) {
                      return DropdownButton<String>(
                        hint: const Text("Select"),
                        onChanged: (newValue) {
                          setState(() {
                            //selectedFc = newValue;
                          });
                        },
                        items: snapshot.data
                            ?.map((fc) => DropdownMenuItem<String>(
                                  value: fc?.categoryname,
                                  child: Text(fc!.categoryname),
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: expensesWidget(),
      ),
      floatingActionButton: SpeedDial(icon: Icons.add,
          // backgroundColor: Colors.amber,
          children: [
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

    //return Container(child: ExpensesWidget());
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
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data![index]!.expensename),
              trailing: Text(snapshot.data![index]!.expensevalue.toString()),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              indent: 20,
              endIndent: 20,
            );
          },
        );
      },
      future: expenseItems,
    );
  }
}
