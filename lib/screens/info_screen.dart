import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PAYSLIP INFO'),
        backgroundColor: Color(0xff01A0C7),
      ),
      body: Container(
        child: Center(
          child: Text('Info'),
        ),
      ),
    );
  }
}
