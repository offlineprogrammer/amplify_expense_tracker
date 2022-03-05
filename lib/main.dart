import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'models/ModelProvider.dart';

import 'amplifyconfiguration.dart';
import 'pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<List<ExpenseItem?>?> _getExpenses() async {
    try {
      print('Start');
      final request = ModelQueries.list(ExpenseItem.classType);
      print('1');
      final response = await Amplify.API.query(request: request).response;
      print('2');
      List<ExpenseItem?>? expenseItems = response.data?.items;
      print(expenseItems!.length);
      return expenseItems;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }

  void _configureAmplify() async {
    Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));

    try {
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _amplifyConfigured
          ? const HomePage(title: 'Flutter Demo Home Page')
          : _waitForAmplify(),
    );
  }

  Scaffold _waitForAmplify() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
