import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoplink/screens/attendance_screen.dart';
import 'package:shoplink/screens/employee_info_screen.dart';
import 'package:shoplink/screens/login_screen.dart';
import 'package:shoplink/screens/project_info_screen.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MaterialButton(
                elevation: 10,
                color: Colors.indigoAccent,
                onPressed: () {
                  Navigator.pushNamed(context, EmployeeScreen.id);
                },
                child: Text('Employees',
                    style: TextStyle(
                      fontSize: 20,
                    )),
              ),
              MaterialButton(
                elevation: 10,
                color: Colors.indigoAccent,
                onPressed: () {
                  Navigator.pushNamed(context, AttendanceScreen.id);
                },
                minWidth: 200,
                child: Text('Attendance', style: TextStyle(fontSize: 20)),
              ),
              MaterialButton(
                elevation: 10,
                color: Colors.indigoAccent,
                onPressed: () {
                  Navigator.pushNamed(context, ProjectInfoScreen.id);
                },
                child: Text('Project Info', style: TextStyle(fontSize: 20)),
              ),
              MaterialButton(
                elevation: 10,
                color: Colors.indigoAccent,
                onPressed: () {
                  var user = _auth.currentUser();
                  if (user != null) {
                    _auth.signOut();
                    Navigator.pushNamed(context, LoginScreen.id);
                  }
                },
                child: Text('Logout', style: TextStyle(fontSize: 20)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
