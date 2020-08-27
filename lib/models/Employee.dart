import 'package:firebase_database/firebase_database.dart';
import 'package:shoplink/screens/employee_info_screen.dart';

class Employee {
  String addBy,
      addressCity,
      addressCountry,
      addressPostalCode,
      addressProvince,
      addressStreet,
      addTime,
      branchID,
      department,
      email,
      employeeName,
      employeeNumber,
      employmentStatus,
      gender,
      hiringAgency,
      payRate,
      phoneNumber,
      shiftRole,
      startDate,
      status,
      statusLog,
      terminationDate,
      vacationDays,
      kID;

  Employee(
      this.addBy,
      this.addressCity,
      this.addressCountry,
      this.addressPostalCode,
      this.addressProvince,
      this.addressStreet,
      this.addTime,
      this.branchID,
      this.department,
      this.email,
      this.employeeName,
      this.employeeNumber,
      this.employmentStatus,
      this.gender,
      this.hiringAgency,
      this.payRate,
      this.phoneNumber,
      this.shiftRole,
      this.startDate,
      this.status,
      this.statusLog,
      this.terminationDate,
      this.vacationDays,
      this.kID);

  static List<Employee> getAllEmployees() {
    List<Employee> employees = new List<Employee>();
    DatabaseReference employeeRef =
        FirebaseDatabase.instance.reference().child("Employees");
    employeeRef.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      employees.clear();
      EmployeeScreen.elements.clear();
      for (int i = 0; i < data.length; i++) {
        Employee emp = new Employee(
            data[i]['AddBy'],
            data[i]['AddTime'],
            data[i]['AddressCity'],
            data[i]['AddressCountry'],
            data[i]['AddressPostalCode'],
            data[i]['AddressProvince'],
            data[i]['AddressStreet'],
            data[i]['BranchID'],
            data[i]['Department'],
            data[i]['Email'],
            data[i]['EmployeeName'],
            data[i]['EmployeeNumber'],
            data[i]['EmploymentStatus'],
            data[i]['Gender'],
            data[i]['HiringAgency'],
            data[i]['PayRate'],
            data[i]['PhoneNumber'],
            data[i]['ShiftRole'],
            data[i]['StartDate'],
            data[i]['Status'],
            data[i]['StatusLog'],
            data[i]['TerminationDate'],
            data[i]['VacationDays'],
            data[i]['kID']);

        if (emp.status == "Active") {
          employees.add(emp);
          EmployeeScreen.elements
              .add({'name': emp.employeeName, 'group': emp.department});
        }
      }
    });
    return employees;
  }

  static String getEmployeeName(String empNum, List<Employee> employees) {
    var number = int.parse(empNum);
    String name = "";
    for (var emp in employees) {
      if (int.parse(emp.employeeNumber) == number) {
        name = emp.employeeName;
      }
    }
    return name;
  }

  static Employee getEmployee(String name, List<Employee> employees) {
    for (var emp in employees) {
      if (emp.employeeName == name) {
        return emp;
      }
    }
  }

  @override
  String toString() {
    return "Name: ${this.employeeName}\nNumber:${this.employeeNumber}\nGender:${this.gender}\nStart Date:${this.startDate}\nTermination Date:${this.terminationDate}\nPay Rate:${this.payRate}\nDepartment:${this.department}\nPhone Number:${this.phoneNumber}\nHiring Agency:${this.hiringAgency}\nAdd By:${this.addBy}\nAdd Time:${this.addTime}\nBranch ID:${this.branchID}\nShift Role:${this.shiftRole}\nVacation Days:${this.vacationDays}\nStatus Log:${this.statusLog}\nStatus:${this.status}\nEmployment Status:${this.employmentStatus}\nEmail:${this.email}\nAddress Street:${this.addressStreet}\nAddress City:${this.addressCity}\nAddress Province:${this.addressProvince}\nAddress Country${this.addressCountry}\nPostal Code:${this.addressPostalCode}";
  }
}
