import 'package:app1/helper/dimensions.dart';
import 'package:app1/scoped_model/main_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  var viewportHeight;
  var viewportWidth;
  var month = '1';
  var year = '2018';
  List<String> years = [
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
  ];
  List<String> months = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Query'),
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (context, child, model) {
          return Center(
            child: Container(
              height: getViewportHeight(context) * 0.8,
              width: getViewportWidth(context) * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.grey.withOpacity(0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'Enter Month & Year',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getViewportHeight(context) * 0.1,
                  ),
                  _dropdown('Enter Month'),
                  _dropdown('Enter Year'),
                  _button('Next', model)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _button(String title, MainModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        width: viewportWidth * 0.5,
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
            model
                .getStudent(month, year,
                    model.authenticatedEmployee.result['employeeCode'])
                .then((value) {
              if (value) {
                Navigator.of(context).pushReplacementNamed('/payslip');
              } else {
                print('API Call Failed!');
              }
            });
          },
        ),
      ),
    );
  }

  Widget _dropdown(String title) {
    List<String> list;
    if (title == 'Enter Month') {
      list = months;
    } else {
      list = years;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          FlatButton(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            onPressed: () {},
            child: new DropdownButton<String>(
              hint: Text(
                title == 'Enter Month' ? month : year,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              items: list.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  if (title == 'Enter Month') {
                    month = value;
                  } else {
                    year = value;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
