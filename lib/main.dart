import 'package:app1/scoped_model/main_scoped_model.dart';
import 'package:app1/screens/auth_screen.dart';
import 'package:app1/screens/home_screen.dart';
import 'package:app1/screens/info_screen.dart';
import 'package:app1/screens/payslip_screen.dart';
import 'package:app1/screens/query_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff01A0C7),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (BuildContext context) => AuthScreen(),
          '/home': (BuildContext context) => HomeScreen(),
          '/info': (BuildContext context) => InfoScreen(),
          '/payslip': (BuildContext context) => PaySlipScreen(),
          '/query': (BuildContext context) => QueryScreen(),
        },
      ),
    );
  }
}
