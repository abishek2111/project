class Info {
  final String employeeCode;
  final String fullName;
  final String designation;
  final String section;
  final String department;
  final Map<String, dynamic> allowances;
  final Map<String, dynamic> deductionByCheque;
  final Map<String, dynamic> deductionByAdjustment;
  final Map<String, dynamic> recoveries;
  final int grossPay;
  final int totalDeduction;
  final int netPay;

  Info({
    this.employeeCode,
    this.fullName,
    this.designation,
    this.section,
    this.department,
    this.allowances,
    this.deductionByAdjustment,
    this.deductionByCheque,
    this.grossPay,
    this.netPay,
    this.recoveries,
    this.totalDeduction,
  });
}
