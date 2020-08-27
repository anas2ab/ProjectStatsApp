import 'package:flutter/material.dart';
import 'package:shoplink/models/Employee.dart';
import 'package:shoplink/screens/employee_info_screen.dart';

class EmployeePage extends StatefulWidget {
  static const String id = 'employee_page';
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  @override
  Widget build(BuildContext context) {
    final EmployeeArguments args = ModalRoute.of(context).settings.arguments;
    Employee emp = args.emp;
    String name = args.name;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Employee Page"),
      ),
      body: Card(
        color: Colors.indigo,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              title: Text(
                name,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                emp.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
