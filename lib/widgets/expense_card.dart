import 'package:expense_tracker_app/controllers/category_controller.dart';
import 'package:expense_tracker_app/controllers/expense_controller.dart';
import 'package:expense_tracker_app/models/Category.dart';
import 'package:expense_tracker_app/models/Expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    ExpenseController _expenseController = Get.find();
    return _buildContent(_expenseController);
  }

  Widget _buildContent(ExpenseController expenseController) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          expenseController.removeExpense(expense);
        }
      },
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      key: ValueKey(expense.id),
      child: _buildCard(expenseController),
    );
  }

  Card _buildCard(ExpenseController expenseController) {
    CategoryController _categoryController = Get.find();
    return Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black12, width: 1),
          borderRadius: BorderRadius.circular(1),
        ),
        child: ListTile(
          dense: true,
          title: Text(
            expense.expensename,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _categoryController.categoriesList
                    .firstWhere((element) => element.id == expense.categoryID)
                    .categoryname,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Wrap(children: [
            Text(
              '-\$' + expense.expensevalue.toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ));
  }
}
