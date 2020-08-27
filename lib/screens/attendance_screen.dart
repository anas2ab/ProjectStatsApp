import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shoplink/models/AttendanceLog..dart';
import 'package:shoplink/models/Employee.dart';

class AttendanceScreen extends StatefulWidget {
  static const String id = 'attendance_screen';
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime _selectedDate;
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    setState(() {
      _loaded = true;
    });
    _selectedDate = DateTime.now();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _loaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Attendance')),
      body: ModalProgressHUD(
        inAsyncCall: _loaded,
        child: Center(
          child: Column(
            children: <Widget>[
              DatePicker(
                DateTime.now().add(Duration(days: -30)),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.indigo,
                selectedTextColor: Colors.white,
                daysCount: 31,
                onDateChange: (date) {
                  // New date selected
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              ExpansionCard(_selectedDate),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpansionCard extends StatefulWidget {
  final DateTime date;
  ExpansionCard(this.date);
  @override
  ExpansionCardState createState() {
    return ExpansionCardState();
  }
}

class ExpansionCardState extends State<ExpansionCard> {
  List<AttendanceLog> logList = [];
  List<Employee> employees = [];
  List<AttendanceLog> filteredLogs = [];
  @override
  void initState() {
    super.initState();
    logList = AttendanceLog.getAllLogs();
    employees = Employee.getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    filteredLogs = AttendanceLog.getWorkedOnDate(this.widget.date, logList);
    return Expanded(
      child: ListView.builder(
        itemCount: filteredLogs.length,
        itemBuilder: (context, index) {
          return ExpansionTileCard(
            baseColor: Colors.white,
            leading: Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
            title: Text(Employee.getEmployeeName(
                        filteredLogs[index].employeeNumber, employees)
                    .isEmpty
                ? filteredLogs[index].employeeNumber
                : Employee.getEmployeeName(
                    filteredLogs[index].employeeNumber, employees)),
            subtitle: Text('Started: ' +
                filteredLogs[index].logTime +
                ', Total: ' +
                filteredLogs[index].totalHrs),
            children: <Widget>[
              Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text('Station: ' + filteredLogs[index].station),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
