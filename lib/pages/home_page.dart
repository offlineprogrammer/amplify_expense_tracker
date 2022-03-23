import 'package:amplify_expense_tracker/widgets/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/ModelProvider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../services/api_service.dart';
import '../widgets/add_category.dart';
import '../widgets/delete_expense.dart';
import '../widgets/update_expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ExpenseItem?>?> expenseItems;
  final APIService _apiService = APIService();

  @override
  void initState() {
    super.initState();
    expenseItems = _apiService.getExpenses();
  }

  late ExpenseCategory _selectedExpenseCategory;

  Future<void> _updateExpenseItem(ExpenseItem expenseItem) async {
    try {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return UpdateExpense(expenseItem, _apiService);
          }).then((value) {
        if (value) {
          setState(() {
            expenseItems = _apiService.getExpenses();
          });
        }
      });
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  Future<void> _deleteExpenseItem(ExpenseItem expenseItem) async {
    try {
      return showDialog(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return DeleteExpense(expenseItem, _apiService);
        },
      ).then((value) {
        if (value) {
          setState(() {
            expenseItems = _apiService.getExpenses();
          });
        }
      });
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddExpense(_apiService);
      },
    ).then((value) {
      if (value) {
        setState(() {
          expenseItems = _apiService.getExpenses();
        });
      }
    });
  }

  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCategory(_apiService);
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
          child: const Icon(Icons.file_copy),
          label: 'Add Category',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onTap: () {
            _showAddCategoryDialog(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.attach_money),
          label: 'Add Expense',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onTap: () {
            _showAddExpenseDialog(context);
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

        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final _expenseitem = snapshot.data![index]!;
            return ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(2.0),
                child:
                    Text('\$${_expenseitem.expensevalue.toStringAsFixed(2)}'),
              ),
              title: Text(_expenseitem.expensename),
              subtitle: Text(_expenseitem.expensecategory.categoryname),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        _updateExpenseItem(_expenseitem);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        _deleteExpenseItem(_expenseitem);
                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
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
