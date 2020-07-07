import 'package:app1/model/Employee.dart';
import 'package:app1/model/Info.dart';

import '../api/keys.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConnectedModel extends Model {
  final uri = ApiKeys.uri;
  Employee authenticatedEmployee;
  Info employeeInfo;

  bool isLoading = false;
  bool isUserAuthenticated = false;

  Future<bool> userLogin(String empCode, String mobile) async {
    isLoading = true;
    notifyListeners();
    print('Inside login : ${empCode}  ${mobile}');
    try {
      http.Response response = await http.get(
          'http://10.182.1.43:8080/api/Employees/GetEmpDetailsForLogin?employeeCode=${empCode}&phoneNo=${mobile}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Inside login success');
        print(response);
        final Map<String, dynamic> res = json.decode(response.body);
        authenticatedEmployee = Employee(
          alertCode: res['alertCode'],
          employeeCodeType: res['employeeCodeType'],
          message: res['message'],
          result: res['result'],
          status: res['status'],
        );

        isLoading = false;
        notifyListeners();
        return true;
      } else {
        print('Error in login success : ${response.statusCode}');

        print(response);
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      print("Error in login:  " + error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> getStudent(String month, String year, String empCode) async {
    isLoading = true;
    notifyListeners();
    print('get Student : ${month} ${year} ${empCode}');
    try {
      http.Response response = await http.get(
          "http://10.182.1.43:8080/api/PaySlip/GetSalaryBillByEmpDetails?EmpCode=${empCode}&Month=${month}&Year=${year}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> res = json.decode(response.body);
        print("api call success");
        print(response);

        employeeInfo = Info(
          allowances: res['allowances'],
          deductionByAdjustment: res['deductionByAdjustment'],
          deductionByCheque: res['deductionByCheque'],
          department: res['department'],
          designation: res['designation'],
          employeeCode: res['employeeCode'],
          fullName: res['fullName'],
          grossPay: res['grossPay'],
          netPay: res['netPay'],
          recoveries: res['recoveries'],
          section: res['section'],
          totalDeduction: res['totalDeduction'],
        );
        print(res);
        print(authenticatedEmployee.result);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      print("Error in info api call:  " + error.toString());
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
