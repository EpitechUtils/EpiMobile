import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';

class ReminderDashboard extends StatefulWidget {
    Dashboard dashboard;
    ModuleBoard moduleBoard;

    ReminderDashboard({Key key, this.dashboard, this.moduleBoard}) : super(key: key);

    @override
    _ReminderDashboard createState() => new _ReminderDashboard();
}

class _ReminderDashboard extends State<ReminderDashboard> {
    int nbNextSessions = 0;

    @override
    void initState() {
        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        // Sort passed activities
	this.widget.dashboard.activities.removeWhere((act) {
            DateFormat format = DateFormat("dd/MM/yyyy");

            return DateTime.now().isAfter(format.parse(act.timelineEnd.split(',')[0]));
	});

	// Sort deliveries in chronological order
        this.widget.moduleBoard.registeredProjects.sort((a, b) {
            return DateTime.parse(a.endActivity).compareTo(DateTime.parse(b.endActivity));
        });

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
                                            "À venir (" + this.widget.dashboard.activities.length.toString() + ")",
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
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: this.widget.dashboard.activities.length,
                                separatorBuilder: (BuildContext context, int index) => Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                                Container(
                                                    padding: EdgeInsets.all(5),
                                                    child: Text(
                                                        this.widget.dashboard.activities[index].module + " " + this.widget.dashboard.activities[index].name,
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
                                                                    "Le " + this.widget.dashboard.activities[index].timelineStart
                                                                ),
                                                            ),
                                                            Container(
                                                                child: Text(
                                                                    (this.widget.dashboard.activities[index].room == null) ? "Salle non spécifiée"
                                                                        : this.widget.dashboard.activities[index].room,
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
                            ),
                        )
                    ],
                ),
            ),
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
                                                "À rendre (" + this.widget.moduleBoard.projectsToDeliveryAmount.toString() + ")",
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
                                child: ListView.separated(
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
                                                    )
                                                ],
                                            )
                                        );
                                    },
                                    separatorBuilder: (BuildContext context, int index) => Divider(),
                                    itemCount: this.widget.moduleBoard.projectsToDeliveryAmount
                                )
                            )
                        ],
                    ),
                ),
            )
        );
  }
}