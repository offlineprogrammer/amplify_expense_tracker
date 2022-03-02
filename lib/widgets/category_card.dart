import 'package:expense_tracker_app/controllers/category_controller.dart';
import 'package:expense_tracker_app/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    CategoryController _categoryController = Get.find();
    return _buildContent(_categoryController);
  }

  Widget _buildContent(CategoryController categoryController) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.startToEnd) {
          categoryController.removeCategory(category);
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
      key: ValueKey(category.id),
      child: _buildCard(categoryController),
    );
  }

  Card _buildCard(CategoryController categoryController) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(1),
      ),
      child: ListTile(
        dense: true,
        title: Text(
          category.categoryname,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
