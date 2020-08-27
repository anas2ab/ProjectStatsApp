import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shoplink/models/ProjectInfo.dart';
import 'package:shoplink/resources/indicator.dart';

class ProjectInfoScreen extends StatefulWidget {
  static const String id = 'project_info_screen';
  @override
  _ProjectInfoScreenState createState() => _ProjectInfoScreenState();
}

class _ProjectInfoScreenState extends State<ProjectInfoScreen> {
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loaded = true;
    });

    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _loaded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(title: Text('Project Info')),
      body: ModalProgressHUD(
        inAsyncCall: _loaded,
        child: ListView(
          children: <Widget>[
//          AspectRatio(
//            aspectRatio: 1.2,
//            child: Card(
//              elevation: 4,
//              shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(6)),
//              color: Colors.white,
//              child: Padding(
//                padding: const EdgeInsets.all(12),
//                child: LineChart(
//                  mainData(),
//                ),
//              ),
//              margin: EdgeInsets.all(20),
//            ),
//          ),
            ProjectDropDown(),
          ],
        ),
      ),
    );
  }

//  LineChartData mainData() {
//    return LineChartData(
//      gridData: FlGridData(
//        show: true,
//        drawVerticalLine: true,
//        getDrawingHorizontalLine: (value) {
//          return FlLine(
//            color: const Color(0xff37434d),
//            strokeWidth: 2,
//          );
//        },
//        getDrawingVerticalLine: (value) {
//          return FlLine(
//            color: const Color(0xff37434d),
//            strokeWidth: 2,
//          );
//        },
//      ),
//      titlesData: FlTitlesData(
//        show: true,
//        bottomTitles: SideTitles(
//          showTitles: true,
//          reservedSize: 22,
//          textStyle: const TextStyle(color: Colors.black, fontSize: 11),
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 1:
//                return '601 W Hastings';
//              case 4:
//                return '800 Palladium';
//              case 7:
//                return 'Expedia Building';
//              case 10:
//                return '401 Bay St';
//            }
//            return '';
//          },
//          margin: 8,
//        ),
//        leftTitles: SideTitles(
//          showTitles: true,
//          textStyle: const TextStyle(
//            color: Colors.black,
//            fontWeight: FontWeight.bold,
//            fontSize: 12,
//          ),
//          getTitles: (value) {
//            switch (value.toInt()) {
//              case 1:
//                return '30';
//              case 2:
//                return '60';
//              case 3:
//                return '90';
//              case 4:
//                return '150';
//              case 5:
//                return '180';
//              case 6:
//                return '210';
//            }
//            return '';
//          },
//          reservedSize: 28,
//          margin: 12,
//        ),
//      ),
//      borderData: FlBorderData(
//          show: true,
//          border: Border.all(color: const Color(0xff37434d), width: 1)),
//      minX: 0,
//      maxX: 11,
//      minY: 0,
//      maxY: 6,
//      axisTitleData: FlAxisTitleData(
//        leftTitle: AxisTitle(
//            showTitle: true,
//            titleText: 'Hours',
//            textStyle: TextStyle(color: Colors.black)),
//        bottomTitle: AxisTitle(
//            showTitle: true,
//            titleText: 'Project',
//            textStyle: TextStyle(color: Colors.black)),
//        topTitle: AxisTitle(
//            showTitle: true,
//            titleText: 'Hours Per Project',
//            textStyle: TextStyle(color: Colors.black)),
//      ),
//      lineBarsData: [
//        LineChartBarData(
//          spots: [
//            FlSpot(1, 3.5),
//            FlSpot(4, 4.6),
//            FlSpot(7, 2.5),
//            FlSpot(10, 5),
//          ],
//          isCurved: true,
//          colors: [Colors.red],
//          barWidth: 3,
//          isStrokeCapRound: true,
//          dotData: FlDotData(
//            show: true,
//          ),
//        ),
//        LineChartBarData(
//          spots: [
//            FlSpot(1, 4),
//            FlSpot(4, 5),
//            FlSpot(7, 4),
//            FlSpot(10, 5),
//          ],
//          isCurved: false,
//          colors: [Colors.green],
//          barWidth: 3,
//          isStrokeCapRound: true,
//          dotData: FlDotData(
//            show: true,
//          ),
//        ),
//      ],
//    );
//  }
}

class ProjectDropDown extends StatefulWidget {
  @override
  ProjectDropDownState createState() {
    return ProjectDropDownState();
  }
}

class ProjectDropDownState extends State<ProjectDropDown> {
  int touchedIndex; // touched index for animation in piechart
  List<Project> projects = Project.getAllProjects(); // get all projects
  List<String> names = []; // list of names of all projects
  List<String> workOrdersByProject = []; // workorders of a project
  String name; // name of project
  List<Color> randColors = [
    Colors.red,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lime,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
    Colors.pink,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.yellow,
    Colors.grey
  ];
  // random colours for the pie chart
  double totalHrsPerProject = 0;

  Stream<int> timedCounter(Duration interval) async* {
    int i = 0;
    while (true) {
      await Future.delayed(interval);
      names = Project.getProjectNames(projects);
      yield i++;

      if (names.isNotEmpty) {
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    workOrdersByProject =
        Project.getProjectWorkOrder(name, projects); // load project workorders
    return ListBody(children: <Widget>[
      AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: StreamBuilder<int>(
                      stream: timedCounter(Duration(milliseconds: 0)),
                      builder: (context, snapshot) {
                        return SearchableDropdown.single(
                          isExpanded: true,
                          hint: "Select Project",
                          value: name,
                          underline: Padding(
                            padding: EdgeInsets.all(5),
                          ),
                          searchHint: "Select Project",
                          onChanged: (String newProject) async {
                            setState(() {
                              totalHrsPerProject = 0;
                              name = newProject;
                            });
                          },
                          items: names
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: name == null
                          ? Text("") // if nothing selected, display nothing
                          : PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                    touchCallback: (pieTouchResponse) {
                                  setState(() {
                                    totalHrsPerProject = 0; // had to reset here
                                    if (pieTouchResponse.touchInput
                                            is FlLongPressEnd ||
                                        pieTouchResponse.touchInput
                                            is FlPanEnd) {
                                      touchedIndex = -1;
                                    } else {
                                      touchedIndex =
                                          pieTouchResponse.touchedSectionIndex;
                                    }
                                  });
                                }),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 45,
                                sections: showingSections(),
                              ),
                            ),
                    ),
                    Flexible(
                      flex: 3,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              for (var i in workOrdersByProject)
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Indicator(
                                      color: randColors[
                                          workOrdersByProject.indexOf(i)],
                                      text: i,
                                      isSquare: true),
                                ),
                              SizedBox(
                                height: 18,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      AspectRatio(
        aspectRatio: 1.5,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: Colors.white,
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              ListTile(
                title:
                    Text("Project Statistics: " + (name == null ? "" : name)),
              ),
              Text(
                "Number of unique work orders: " +
                    workOrdersByProject.length.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Center(
                        child: Column(
                      children: <Widget>[
                        Text(printHours()),
                      ],
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Number of total hours worked: " + getTotalHours().toString(),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  String printHours() {
    double hrs = 0;
    String result = "";
    for (int i = 0; i < workOrdersByProject.length; i++) {
      hrs =
          Project.getHoursPerWorkOrder(workOrdersByProject[i], projects, name);
      result += "${workOrdersByProject[i]}: $hrs\n";
    }
    return result;
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> data = name == null
        ? List.generate(
            1,
            (i) {
              final isTouched = i == touchedIndex;
              final double fontSize = isTouched ? 25 : 14;
              final double radius = isTouched ? 60 : 50;
              return PieChartSectionData(
                color: Colors.blue,
                value: 1,
                title: "0",
                radius: radius,
                titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff),
                ),
              );
            },
          )
        : List.generate(
            workOrdersByProject.length,
            (i) {
              final isTouched = i == touchedIndex;
              final double fontSize = isTouched ? 25 : 14;
              final double radius = isTouched ? 60 : 50;
              return PieChartSectionData(
                color: randColors[i],
                value: Project.getHoursPerWorkOrder(
                            workOrdersByProject[i], projects, name) >
                        0
                    ? Project.getHoursPerWorkOrder(
                        workOrdersByProject[i], projects, name)
                    : 1,
                showTitle: false,
                title: Project.getHoursPerWorkOrder(
                            workOrdersByProject[i], projects, name) >
                        0
                    ? Project.getHoursPerWorkOrder(
                            workOrdersByProject[i], projects, name)
                        .toString()
                    : "0",
                radius: radius,
                titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffffffff),
                ),
              );
            },
          );

    return data;
  }

  double getTotalHours() {
    for (var i = 0; i < workOrdersByProject.length; i++) {
      totalHrsPerProject +=
          Project.getHoursPerWorkOrder(workOrdersByProject[i], projects, name);
    }

    return totalHrsPerProject;
  }
}
