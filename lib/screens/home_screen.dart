import 'package:app1/helper/dimensions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var viewportHeight;
  var viewportWidth;

  Widget _button(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        width: viewportWidth * 0.7,
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: viewportHeight * 0.03,
              ),
            ),
          ),
          onPressed: () {
            if (title == 'INFORMATION') {
              Navigator.of(context).pushNamed('/info');
            } else {
              Navigator.of(context).pushNamed('/query');
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('HOMEPAGE'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: viewportHeight * 0.2,
            ),
            Center(
              child: Text(
                'Payroll App',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.indigo[900]),
              ),
            ),
            _button('INFORMATION'),
            _button('PAYSLIP'),
          ],
        ),
      ),
    ));
  }
}
