import 'package:app1/helper/dimensions.dart';
import 'package:app1/scoped_model/main_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class PaySlipScreen extends StatefulWidget {
  @override
  _PaySlipScreenState createState() => _PaySlipScreenState();
}

class _PaySlipScreenState extends State<PaySlipScreen> {
  var viewportHeight;
  var viewportWidth;
  @override
  Widget build(BuildContext context) {
    viewportHeight = getViewportHeight(context);
    viewportWidth = getViewportWidth(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('PAYSLIP INFO'),
        backgroundColor: Color(0xff01A0C7),
      ),
      body:  ScopedModelDescendant<MainModel>(
        builder: (context, child, model) {
          return Center(
        child: Container(
          
          height: viewportHeight * 0.8,
          width: viewportWidth * 0.9,
          // color: Colors.white,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
              )
            ],
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: Text('LogoSpace'),
              ),
              SizedBox(
                height: viewportHeight * 0.05,
              ),
              _buildEntry('Name', model.employeeInfo.fullName),
              _buildEntry('Department', model.employeeInfo.department),
              _buildEntry('Designation', model.employeeInfo.designation),
              Divider(),
              _buildEntry('ALLOWANCES', ''),
              _buildEntry('Basic Pay',model.employeeInfo.allowances['Basic']),
              _buildEntry('DA', model.employeeInfo.allowances['DA']),
              _buildEntry('SBCA',model.employeeInfo.allowances['SBCA']),
              _buildEntry('HRAWS', model.employeeInfo.allowances['HRAWS']),
            ],
          ),
        ),
      );
       },
      ),
    
    );
  }

  Widget _buildEntry(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              title + ' :',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: viewportHeight * 0.024),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
