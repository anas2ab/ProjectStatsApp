import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';

class EmployeeLog {
  String approvalTime,
      approvedBy,
      approvedStatus,
      deleted,
      employeeNumber,
      kID,
      logChange,
      logTime,
      machineID,
      modBy,
      modTime,
      originalLogTime,
      shiftText,
      shiftType,
      station,
      status,
      totalHrs,
      uPaidHrs,
      woid;

  EmployeeLog(
      this.approvalTime,
      this.approvedBy,
      this.approvedStatus,
      this.deleted,
      this.employeeNumber,
      this.kID,
      this.logChange,
      this.logTime,
      this.machineID,
      this.modBy,
      this.modTime,
      this.originalLogTime,
      this.shiftText,
      this.shiftType,
      this.station,
      this.status,
      this.totalHrs,
      this.uPaidHrs,
      this.woid);

  static List<EmployeeLog> getAllLogs() {
    List<EmployeeLog> logList = [];
    DatabaseReference employeeRef =
        FirebaseDatabase.instance.reference().child("EmployeeLog");
    employeeRef.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      logList.clear();
      for (int i = 0; i < data.length; i++) {
        EmployeeLog log = new EmployeeLog(
            data[i]['ApprovalTime'],
            data[i]['ApprovedBy'],
            data[i]['ApprovedStatus'],
            data[i]['Deleted'],
            data[i]['EmployeeNumber'],
            data[i]['kID'],
            data[i]['LogChange'],
            data[i]['LogTime'],
            data[i]['MachineID'],
            data[i]['ModBy'],
            data[i]['ModTime'],
            data[i]['OriginalLogTime'],
            data[i]['ShiftText'],
            data[i]['ShiftType'],
            data[i]['Station'],
            data[i]['Status'],
            data[i]['TotalHrs'],
            data[i]['UpaidHours'],
            data[i]['WOID']);
        logList.add(log);
      }
    });
    return logList;
  }

  static bool equals(EmployeeLog log1, EmployeeLog log2) {
    return log1.employeeNumber == log2.employeeNumber;
  }

  static List<EmployeeLog> getWorkedOnDate(
      DateTime date, List<EmployeeLog> logList) {
    List<EmployeeLog> results = [];
    var newDate = formatDate(date, [yyyy, '-', mm, '-', dd]);
    for (var log in logList) {
      var parsedDate =
          formatDate(DateTime.parse(log.logTime), [yyyy, '-', mm, '-', dd]);
      if (parsedDate == newDate) results.add(log);
    }
    return results;
  }
}
