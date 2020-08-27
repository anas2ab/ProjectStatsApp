import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';

class AttendanceLog {
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

  AttendanceLog(
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

  static List<AttendanceLog> getAllLogs() {
    List<AttendanceLog> logList = [];
    DatabaseReference employeeRef =
        FirebaseDatabase.instance.reference().child("AttendanceLog");
    employeeRef.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      logList.clear();
      for (int i = 0; i < data.length; i++) {
        AttendanceLog log = new AttendanceLog(
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

  static bool equals(AttendanceLog log1, AttendanceLog log2) {
    return log1.employeeNumber == log2.employeeNumber;
  }

  static List<AttendanceLog> getWorkedOnDate(
      DateTime date, List<AttendanceLog> logList) {
    List<AttendanceLog> results = [];
    var newDate = formatDate(date, [yyyy, '-', mm, '-', dd]);
    for (var log in logList) {
      var parsedDate =
          formatDate(DateTime.parse(log.logTime), [yyyy, '-', mm, '-', dd]);
      if (parsedDate == newDate) results.add(log);
    }
    return results;
  }
}
