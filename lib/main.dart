import 'package:flutter/material.dart';
import 'package:shoplink/screens/employee_page.dart';
import 'package:shoplink/screens/login_screen.dart';

import 'screens/attendance_screen.dart';
import 'screens/employee_info_screen.dart';
import 'screens/home_page.dart';
import 'screens/project_info_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flynn Reports',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        HomePage.id: (context) => HomePage(),
        EmployeeScreen.id: (context) => EmployeeScreen(),
        AttendanceScreen.id: (context) => AttendanceScreen(),
        ProjectInfoScreen.id: (context) => ProjectInfoScreen(),
        EmployeePage.id: (context) => EmployeePage(),
      },
    );
  }
}
