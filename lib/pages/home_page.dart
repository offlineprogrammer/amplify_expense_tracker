import 'package:amplify_expense_tracker/widgets/add_expense.dart';
import 'package:flutter/material.dart';
import '../models/ModelProvider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../services/api_service.dart';
import '../widgets/add_category.dart';
import '../widgets/delete_expense.dart';
import '../widgets/update_expense.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final APIService _apiService = APIService();

  List<ExpenseItem> _expenseItems = const [];

  @override
  void initState() {
    super.initState();
    _getLatestExpenseItems();
  }

  Future<void> _getLatestExpenseItems() async {
    try {
      final expenseItems = await _apiService.getExpenses();
      setState(() {
        _expenseItems =
            expenseItems?.whereType<ExpenseItem>().toList() ?? const [];
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      ));
    }
  }

  Future<void> _updateExpenseItem(ExpenseItem expenseItem) async {
    var value = await showDialog<ExpenseItem>(
        context: context,
        builder: (BuildContext context) {
          return UpdateExpense(expenseItem, _apiService);
        });
    if (value != null) {
      await _apiService.updateExpense(value);
      await _getLatestExpenseItems();
    }
  }

  Future<void> _deleteExpenseItem(ExpenseItem expenseItem) async {
    var value = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return const DeleteExpense();
        });
    value ??= false;

    if (value) {
      await _apiService.deleteExpense(expenseItem);
      await _getLatestExpenseItems();
    }
  }

  void _showAddExpenseDialog(BuildContext context) async {
    var value = await showDialog<ExpenseItem>(
      context: context,
      builder: (BuildContext context) {
        return AddExpense(_apiService);
      },
    );
    if (value != null) {
      await _apiService.saveExpense(value);
      await _getLatestExpenseItems();
    }
  }

  void _showAddCategoryDialog(BuildContext context) async {
    var value = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddCategory(_apiService);
      },
    );
    if (value != null) {
      await _apiService.saveCategory(value);
    }
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
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: _expenseItems.length,
      itemBuilder: (context, index) {
        final _expenseitem = _expenseItems[index];
        return ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text('\$${_expenseitem.expensevalue.toStringAsFixed(2)}'),
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
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _deleteExpenseItem(_expenseitem);
                },
                icon: const Icon(Icons.delete),
              ),
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
  }
}
