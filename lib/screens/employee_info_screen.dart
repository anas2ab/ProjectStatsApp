import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shoplink/models/Employee.dart';
import 'package:shoplink/screens/employee_page.dart';

class EmployeeScreen extends StatefulWidget {
  static const String id = 'employee_screen';
  static List elements = [];

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  List<Employee> employees = Employee.getAllEmployees();
  bool _showSpinner = false;
  @override
  void initState() {
    super.initState();
    _isLoaded();
  }

  void _isLoaded() {
    setState(() {
      _showSpinner = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showSpinner = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Employees'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: GroupedListView<dynamic, String>(
          groupBy: (element) => element['group'],
          elements: EmployeeScreen.elements,
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: false,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              color: Colors.indigo,
              elevation: 8.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  title: Text(
                    element['name'],
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      //Navigator.pushNamed(context, EmployeePage.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmployeePage(),
                          settings: RouteSettings(
                            arguments: EmployeeArguments(
                                element['name'],
                                Employee.getEmployee(
                                    element['name'], employees)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class EmployeeArguments {
  final String name;
  final Employee emp;

  EmployeeArguments(this.name, this.emp);
}
