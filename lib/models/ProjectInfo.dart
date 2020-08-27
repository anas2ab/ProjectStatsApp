import 'package:dartx/dartx.dart';
import 'package:firebase_database/firebase_database.dart';

class Project {
  String totalHrs, woid, dynamicsNumber, workOrderNumber, projectName;

  Project(this.totalHrs, this.woid, this.dynamicsNumber, this.workOrderNumber,
      this.projectName);

  static List<Project> getAllProjects() {
    List<Project> projects = [];
    DatabaseReference employeeRef =
        FirebaseDatabase.instance.reference().child("ProjectInfo");
    employeeRef.once().then((DataSnapshot snapshot) {
      var data = snapshot.value;
      projects.clear();
      for (int i = 0; i < data.length; i++) {
        Project proj = new Project(
            data[i]['TotalHrs'],
            data[i]['WOID'],
            data[i]['DynamicsNumber'],
            data[i]['WorkOrderNumber'],
            data[i]['ProjectName']);
        projects.add(proj);
      }
    });
    return projects;
  }

  static List<String> getProjectNames(List<Project> projects) {
    List<String> names = [];
    for (var proj in projects) {
      names.add(proj.projectName);
    }
    return names.distinct().toList();
  }

  static List<String> getProjectWorkOrder(String name, List<Project> projects) {
    List<String> workorder = [];
    for (var proj in projects) {
      if (proj.projectName == name) {
        String workName = "${proj.woid} ${proj.workOrderNumber}";
        if (!workorder.contains(workName)) workorder.add(workName);
      }
    }
    return workorder;
  }

  static double getHoursPerWorkOrder(
      String workOrder, List<Project> projects, String projName) {
    double total = 0;

    var woid = workOrder.split(" ");
    workOrder = woid[0];

    for (var proj in projects) {
      if (projName == proj.projectName &&
          workOrder == proj.woid &&
          proj.totalHrs.isNotEmpty) {
        total += double.tryParse(proj.totalHrs);
      }
    }
    total = total.roundToDouble();
    return total;
  }
}
