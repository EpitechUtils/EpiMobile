import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';

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
        return Container(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView(
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
            padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                        // Header
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                children: <Widget>[
                                    Container(
                                        child: Icon(
                                            Icons.schedule,
                                            color: Theme.of(context).primaryColor
                                        ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                        child: Text("Prochaines activités",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20,
                                                color: Theme.of(context).primaryColor
                                            )
                                        ),
                                    ),
                                ],
                            )
                        ),

                        // Content
                        Container(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: this.widget.dashboard.activities.length,
                                separatorBuilder: (BuildContext context, int index) => Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                        child: Row(
                                            children: <Widget>[

                                                // Registered or not badge
                                                SizedBox(
                                                    height: 50,
                                                    width: 3,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: (this.widget.dashboard.activities[index].inscriptionDate is bool) ? Color(0xFF2ecc71) : Color(0xFFe74c3c),
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
                                                                child: Text(
                                                                    this.widget.dashboard.activities[index].module + " | " + this.widget.dashboard.activities[index].name,
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
                                                                            child: Text(
                                                                                "Le " + this.widget.dashboard.activities[index].timelineStart
                                                                            ),
                                                                        ),
                                                                        Container(
                                                                            child: Text(
                                                                                (this.widget.dashboard.activities[index].room == null) ? "Salle non spécifiée"
                                                                                    : this.widget.dashboard.activities[index].room,
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
                                    );
                                },
                            )
                        )
                    ],
                ),
            ),
        );
    }

    Widget buildNextDelivery() {
        if (this.widget.moduleBoard.registeredProjects.length == 0)
            return Container();

        return Container(
            padding: EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Card(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                        // Header
                        Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                children: <Widget>[
                                    Container(
                                        child: Icon(
                                            Icons.access_alarm,
                                            color: Theme.of(context).primaryColor
                                        ),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                        child: Text("Projets à rendre",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20,
                                                color: Theme.of(context).primaryColor
                                            )
                                        ),
                                    ),
                                ],
                            )
                        ),

                        // Content
                        Container(
                            padding: EdgeInsets.all(10),
                            child: ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (BuildContext context, int index) => Divider(),
                                itemCount: this.widget.moduleBoard.projectsToDeliveryAmount,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                Container(
                                                    child: Row(
                                                        children: <Widget>[
                                                            Container(
                                                                child: Text(
                                                                    this.widget.moduleBoard.registeredProjects[index].moduleName + " : ",
                                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                                ),
                                                            ),
                                                            Container(
                                                                child: Text(
                                                                    DateFormat("dd/MM/yyyy").format(DateTime.parse(this.widget.moduleBoard.registeredProjects[index].endActivity)).toString()
                                                                ),
                                                            )
                                                        ],
                                                    ),
                                                ),
                                                Text(
                                                    this.widget.moduleBoard.registeredProjects[index].name,
                                                ),
                                            ],
                                        ),
                                    );
                                },
                            )
                        )
                    ],
                ),
            ),
        );
    }

}