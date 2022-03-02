import 'package:flutter/material.dart';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'models/ModelProvider.dart';

import 'amplifyconfiguration.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // Add the following line to add API plugin to your app
    Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _expenseCategoryController =
      TextEditingController();
  final TextEditingController _expenseValueController = TextEditingController();
  final TextEditingController _expenseNameController = TextEditingController();

  Future<void> _submit() async {}

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
    } on ApiException catch (e) {
      print('Mutation failed: $e');
    }
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
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
                  style: new TextStyle(fontSize: 70, color: Colors.black),
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: "0.00"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onEditingComplete: () => _submit(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  autocorrect: false,
                  decoration: InputDecoration(hintText: "Expense Name"),
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => _submit(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
              ]),
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: _submit, //,
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
          title: Text(
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
                    decoration: InputDecoration(hintText: "Category Name"),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _saveCategory(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
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

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
