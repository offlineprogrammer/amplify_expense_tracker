import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'models/ModelProvider.dart';

import 'amplifyconfiguration.dart';
import 'pages/home_page.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

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

  void _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        AmplifyAuthCognito(),
        AmplifyAPI(modelProvider: ModelProvider.instance)
      ]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Tried to reconfigure Amplify; '
          'this can occur when your app restarts on Android.',
        ),
      ));
    }
  }

  Widget buildApp(BuildContext context) {
    return _amplifyConfigured
        ? const HomePage(title: 'Amplify Expense')
        : _waitForAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: buildApp(context),
        scaffoldMessengerKey: scaffoldMessengerKey,
      ),
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
