import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/BoardModule.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';
import 'package:mobile_intranet/parser/components/subcomponents/Activity.dart';

/// ReminderDashboard from dashboard
class ReminderDashboard extends StatefulWidget {

    final Dashboard dashboard;
    final ModuleBoard moduleBoard;

    ReminderDashboard({Key key, this.dashboard, this.moduleBoard}) : super(key: key);

    @override
    _ReminderDashboard createState() => new _ReminderDashboard();
}

/// ReminderDashboard state class
/// Extended from [State]
class _ReminderDashboard extends State<ReminderDashboard> {

    int nbNextSessions = 0;

    /// State initiation and create data from
    @override
    void initState() {
        super.initState();

        // Sort passed activities
        this.widget.dashboard.activities.removeWhere((act) {
            String end = act.timelineEnd.replaceAll('h', ':');
            DateFormat format = DateFormat("dd/MM/yyyy, h:mm");

            return DateTime.now().isAfter(format.parse(end));
        });

        // Sort deliveries in chronological order
        this.widget.moduleBoard.registeredProjects.sort((a, b) {
            return DateTime.parse(a.endActivity).compareTo(DateTime.parse(b.endActivity));
        });
    }

    /// Build render
    @override
    Widget build(BuildContext context) {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    this.buildNextSession(),
                    this.buildNextDelivery(),
                ],
            ),
        );
    }

    /// Build all next sessions
    Widget buildNextSession() {
        if (this.widget.dashboard.activities.length == 0)
            return Container();

        return Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text("Prochaines activités",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor
                        )
                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                            children: () {
                                List<Widget> activitiesListWidget = [];

                                // Add all activities
                                this.widget.dashboard.activities.forEach((Activity activity) {
                                    Widget activityWidget = Container(
                                        decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Color(0xFF464646).withOpacity(0.2),
                                                    blurRadius: 6.0,
                                                )
                                            ]
                                        ),
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Container(
                                                padding: const EdgeInsets.all(10),
                                                color: Theme.of(context).cardColor,
                                                child: Container(
                                                    child: Row(
                                                        children: <Widget>[

                                                            // Registered or not badge
                                                            SizedBox(
                                                                height: 35,
                                                                width: 3,
                                                                child: Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: (activity.inscriptionDate is bool) ? Color(0xFF2ecc71) : Color(0xFFe74c3c),
                                                                    ),
                                                                ),
                                                            ),

                                                            SizedBox(width: 5),

                                                            // Content
                                                            Expanded(
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: <Widget>[
                                                                        Container(
                                                                            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                                                                            child: Text(activity.module + " | " + activity.name,
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.w600
                                                                                ),
                                                                            ),
                                                                        ),

                                                                        Container(
                                                                            padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                                                                            child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                    Container(
                                                                                        child: Text("Le " + activity.timelineStart),
                                                                                    ),
                                                                                    Container(
                                                                                        child: Text(
                                                                                            (activity.room == null) ? "Salle non spécifiée"
                                                                                                : activity.room,
                                                                                            style: TextStyle(fontStyle: FontStyle.italic),
                                                                                        ),
                                                                                    ),
                                                                                ],
                                                                            ),
                                                                        )
                                                                    ]
                                                                ),
                                                            )
                                                        ],
                                                    )
                                                )
                                            )
                                        )
                                    );

                                    // Add to list
                                    activitiesListWidget.add(activityWidget);
                                });

                                return activitiesListWidget;
                            }(),
                        ),
                    )
                ],
            ),
        );
    }

    Widget buildNextDelivery() {
        if (this.widget.moduleBoard.registeredProjects.length == 0)
            return Container();

        return Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text("Projets à rendre",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor
                        )
                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                            children: () {
                                List<Widget> projectsListWidget = [];

                                // Add all activities
                                this.widget.moduleBoard.registeredProjects.forEach((BoardModule project) {
                                    Widget projectWidget = Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                            border: Border.all(
                                                color: Color(0xFFABABAB),
                                                width: 1,
                                            )
                                        ),
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            //color: Theme.of(context).cardColor,
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                            Container(
                                                                child: Row(
                                                                    children: <Widget>[
                                                                        Container(
                                                                            child: Text(project.moduleName + " : ",
                                                                                style: TextStyle(fontWeight: FontWeight.w600),
                                                                            ),
                                                                        ),
                                                                        Container(
                                                                            child: Text(
                                                                                DateFormat("dd/MM/yyyy").format(DateTime.parse(project.endActivity)).toString()
                                                                            ),
                                                                        )
                                                                    ],
                                                                ),
                                                            ),
                                                            Text(project.name,),
                                                        ],
                                                    ),

                                                    Icon(Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                        size: 15,
                                                    )
                                                ],
                                            )
                                        )
                                    );

                                    // Add to list
                                    projectsListWidget.add(projectWidget);
                                });

                                return projectsListWidget;
                            }(),
                        ),
                    )
                ],
            ),
        );
    }

}