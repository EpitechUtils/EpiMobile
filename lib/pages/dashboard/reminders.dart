import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/components/customLoader.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

/// ReminderDashboard class
/// Extends class [StatefulWidget]
class ReminderDashboard extends StatefulWidget {

    final Parser parser;

    /// Constructor of the reminder dashboard
    ReminderDashboard({@required this.parser});

    /// Create state
    @override
    _ReminderDashboard createState() => _ReminderDashboard();
}

/// State class of the [ReminderDashboard]
class _ReminderDashboard extends State<ReminderDashboard> {

    int nbNextSessions = 0;
    Dashboard _dashboard;
    ModuleBoard _moduleBoard;

    /// Init the new state
    @override
    void initState() {
        super.initState();
        
        // Parse dashboard and modulesboard
        Future.wait([this.parseDashboardData(), this.parseModulesDashboadData()])
            .then((results) {
                this.setState(() {
                    this._dashboard = results[0];
                    this._moduleBoard = results[1];
                });
            });
    }

    /// Parsing dashboard data
    Future parseDashboardData() {
        return this.widget.parser.parseDashboard().then((data) {
            var dashboardData = data;

            // Remove activities by date
            dashboardData.activities.removeWhere((act) {
                String end = act.timelineEnd.replaceAll('h', ':');
                DateFormat format = DateFormat("dd/MM/yyyy, h:mm");

                return DateTime.now().isAfter(format.parse(end));
            });

            return dashboardData;
        });
    }

    /// Parse modules dashboard
    Future parseModulesDashboadData() {
        var now = DateTime.now();
        var lastDayDateTime = (now.month < 12) ? DateTime(now.year, now.month + 1, 0) : DateTime(now.year + 1, 1, 0);

        return this.widget.parser.parseModuleBoard(now, lastDayDateTime)
            .then((data) {
                var moduleData = data;

                // Filter registered projects (asc order)
                moduleData.registeredProjects.sort((a, b) {
                    return DateTime.parse(a.endActivity).compareTo(DateTime.parse(b.endActivity));
                });

                return moduleData;
            });
    }

    @override
    Widget build(BuildContext context) {
        if (this._dashboard == null) {
            return CustomLoader();
        }

        return Column(
            children: <Widget>[

                // Next activities
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text("Activités à venir",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "CalibreSemibold",
                                letterSpacing: 1.0,
                            )
                        ),

                        // Activites length
                        Text(this._dashboard.activities.length.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.0,
                                fontFamily: "CalibreSemibold",
                                letterSpacing: 1.0,
                            )
                        ),
                    ],
                ),

                // Activities list
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: this._dashboard.activities.length,
                        separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.white),
                        itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                Text(
                                                    this._dashboard.activities[index].module + " " + this._dashboard.activities[index].name,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.white
                                                    ),
                                                ),

                                                Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                        Container(
                                                            child: Text("Le " + this._dashboard.activities[index].timelineStart,
                                                                style: TextStyle(
                                                                    color: Colors.white
                                                                )
                                                            ),
                                                        ),
                                                        Container(
                                                            child: Text(
                                                                (this._dashboard.activities[index].room == null) ? "Salle non spécifiée"
                                                                    : this._dashboard.activities[index].room,
                                                                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                                                            ),
                                                        )
                                                    ],
                                                ),
                                            ]
                                        ),

                                        IconButton(
                                            onPressed: () {
                                                final Event event = Event(
                                                    title: this._dashboard.activities[index].name,
                                                    description: "Activité dirigée par " + this._dashboard.activities[index].teacher,
                                                    location: "Salle " + this._dashboard.activities[index].room,
                                                    startDate: DateFormat("dd/MM/yyyy, HH:mm").parse(this._dashboard.activities[index].timelineStart),
                                                    endDate: DateFormat("dd/MM/yyyy, HH:mm").parse(this._dashboard.activities[index].timelineEnd),
                                                    allDay: false
                                                );

                                                Add2Calendar.addEvent2Cal(event);
                                            },
                                            icon: Icon(Icons.alarm_add,
                                                color: Colors.blueAccent,
                                            ),

                                        )
                                    ],
                                )
                            );





                            return Container(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                            this._dashboard.activities[index].module + " " + this._dashboard.activities[index].name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white
                                            ),
                                        ),

                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Container(
                                                    child: Text("Le " + this._dashboard.activities[index].timelineStart,
                                                        style: TextStyle(
                                                            color: Colors.white
                                                        )
                                                    ),
                                                ),
                                                Container(
                                                    child: Text(
                                                        (this._dashboard.activities[index].room == null) ? "Salle non spécifiée"
                                                            : this._dashboard.activities[index].room,
                                                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                                                    ),
                                                )
                                            ],
                                        ),
                                    ]
                                )
                            );
                        },
                    ),
                ),

                Divider(color: Colors.white70),
                SizedBox(height: 10),

                // Next activities
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        Text("Projets à rendre",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: "CalibreSemibold",
                                letterSpacing: 1.0,
                            )
                        ),

                        // Amount
                        Text(this._moduleBoard.projectsToDeliveryAmount.toString(),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20.0,
                                fontFamily: "CalibreSemibold",
                                letterSpacing: 1.0,
                            )
                        ),
                    ],
                ),

            ],
        );



        return Container(
            decoration: new BoxDecoration(
                color: Colors.black,
                boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(50, 31, 40, 51),
                        offset: Offset(-5, 0),
                        blurRadius: 20,
                    )
                ],
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                    image: AssetImage("assets/images/background.png")
                )
            ),
            child: Column(
                children: <Widget>[
                    buildNextSession(),
                    buildNextDelivery(),
                ],
            ),
        );
    }

    Widget buildNextSession() {
        return Container(
            padding: EdgeInsets.all(4),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Container(
                                        child: Text(
                                            "À venir (" + this._dashboard.activities.length.toString() + ")",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20,
                                                fontFamily: "NunitoSans",
                                                color: Color.fromARGB(255, 41, 155, 203)
                                            )
                                        ),
                                    ),
                                    Container(
                                        child: Icon(
                                            Icons.schedule,
                                            color: Color.fromARGB(255, 41, 155, 203),
                                        ),
                                    )
                                ],
                            )
                        ),
                        Container(
                            padding: EdgeInsets.all(10),
                            height: 200,
                            child: buildNextSessionsContent()
                        )
                    ],
                ),
            ),
        );
    }

    Widget buildNextSessionsContent() {
        if (this._dashboard.activities.length == 0) {
            return Container(
                alignment: Alignment.center,
                child: Icon(Icons.beach_access, color: Colors.blueAccent, size: 75),
            );
        }

        return ListView.separated(
            shrinkWrap: true,
            itemCount: this._dashboard.activities.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                    this._dashboard.activities[index].module + " " + this._dashboard.activities[index].name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600
                                    ),
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Container(
                                            child: Text(
                                                "Le " + this._dashboard.activities[index].timelineStart
                                            ),
                                        ),
                                        Container(
                                            child: Text(
                                                (this._dashboard.activities[index].room == null) ? "Salle non spécifiée"
                                                    : this._dashboard.activities[index].room,
                                                style: TextStyle(fontStyle: FontStyle.italic),
                                            ),
                                        )
                                    ],
                                ),
                            )
                        ]
                    )
                );
            },
        );
    }

    Widget buildNextDelivery() {
        return Flexible(
            child: Container(
                padding: EdgeInsets.all(4),
                child: Card(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Container(
                                            child: Text(
                                                "À rendre (" + this._moduleBoard.projectsToDeliveryAmount.toString() + ")",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 20,
                                                    fontFamily: "NunitoSans",
                                                    color: Color.fromARGB(255, 41, 155, 203)
                                                )
                                            ),
                                        ),
                                        Container(
                                            child: Icon(
                                                Icons.send,
                                                color: Color.fromARGB(255, 41, 155, 203),
                                            ),
                                        )
                                    ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.all(5),
                                height: MediaQuery.of(context).size.height / 5 + 10,
                                child: buildNextDeliveryContent()
                            )
                        ],
                    ),
                ),
            )
        );
    }

    Widget buildNextDeliveryContent() {
        if (this._moduleBoard.registeredProjects.length == 0) {
            return Container(
                alignment: Alignment.center,
                child: Icon(Icons.beach_access, color: Colors.blueAccent, size: 75),
            );
        }

        return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Row(
                        children: <Widget>[
                            Container(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Container(
                                            child: Row(
                                                children: <Widget>[
                                                    Container(
                                                        child: Text(
                                                            this._moduleBoard.registeredProjects[index].moduleName + " : ",
                                                            style: TextStyle(fontWeight: FontWeight.w600),
                                                        ),
                                                    ),
                                                    Container(
                                                        child: Text(
                                                            DateFormat("dd/MM/yyyy").format(DateTime.parse(this._moduleBoard.registeredProjects[index].endActivity)).toString()
                                                        ),
                                                    )
                                                ],
                                            ),
                                        ),
                                        Text(
                                            this._moduleBoard.registeredProjects[index].name,
                                        ),
                                    ],
                                ),
                            )
                        ],
                    )
                );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: this._moduleBoard.projectsToDeliveryAmount
        );
    }
}