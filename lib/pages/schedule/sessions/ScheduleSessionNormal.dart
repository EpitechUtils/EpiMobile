import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/components/loadingComponent.dart';
import 'package:mobile_intranet/pages/schedule.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleProfessor.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/utils/network/intranetAPIUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Display normal session with groups and description
class ScheduleSessionNormal extends StatefulWidget {
    final ScheduleSession scheduleSession;

    ScheduleSessionNormal({@required this.scheduleSession});

    @override
    State<StatefulWidget> createState() => _ScheduleSessionNormalState();
}

class _ScheduleSessionNormalState extends State<ScheduleSessionNormal> {

    String _autolog;

    @override
    void initState() {
        super.initState();
        SharedPreferences.getInstance()
            .then((prefs) => this.setState(() => this._autolog = prefs.getString("autolog_url")));
    }

    /*Widget buildInformation(BuildContext context) {
        return Container(
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                            child: Text(
                                "Informations",
                                style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                        )),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Container(
                                child: Column(
                                    children: <Widget>[
                                        Icon(
                                            Icons.people,
                                        ),
                                        Text(this
                                            .widget
                                            .scheduleSession
                                            .numberStudentsRegistered
                                            .toString())
                                    ],
                                )),
                            Container(
                                child: Column(
                                    children: <Widget>[
                                        Icon(
                                            Icons.hourglass_full,
                                        ),
                                        Text(this.widget.scheduleSession.hoursAmount)
                                    ],
                                )),
                            Container(
                                child: Column(
                                    children: <Widget>[
                                        Icon(
                                            Icons.location_on,
                                        ),
                                        Text(this.widget.scheduleSession.room.code.substring(
                                            this.widget.scheduleSession.room.code.lastIndexOf('/') +
                                                1,
                                            this.widget.scheduleSession.room.code.length))
                                    ],
                                ))
                        ],
                    )
                ],
            ),
        );
    }

    Widget buildProfessors(BuildContext context) {
        return Expanded(
            child: Column(
                children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                            child: Text(
                                "Professeurs",
                                style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                        )),
                    Flexible(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: this.widget.scheduleSession.professors.length,
                            itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(this
                                                        .widget
                                                        .preferences
                                                        .getString("autolog_url") +
                                                        "/file/userprofil/" +
                                                        this
                                                            .widget
                                                            .scheduleSession
                                                            .professors[index]
                                                            .login
                                                            .split('@')[0] +
                                                        ".bmp"))))));
                            }),
                    )
                ],
            ),
        );
    }*/

    Widget registeredOrNot() {
        //if (this.widget.scheduleSession is bool)
        return Container(
            child: Row(
                children: <Widget>[
                    Icon(Icons.check_circle_outline,
                        color: Colors.green,
                        size: 20,
                    ),
                    Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text("Vous êtes inscrit(e) à cette activité.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17
                            ),
                        ),
                    )
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        if (_autolog == null)
            return LoadingComponent.getBody(context);

        return Column(
            children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 15, top: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color(0xFF464646).withOpacity(0.2),
                                    blurRadius: 15.0,
                                )
                            ]
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: SchedulePage.getSessionColor(this.widget.scheduleSession),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Row(
                                                children: <Widget>[
                                                    // Icon status of the activity
                                                    () {
                                                        ScheduleSession event = this.widget.scheduleSession;
                                                        if (event.eventRegistered is bool)
                                                            return Container();

                                                        try {
                                                            String status = event.eventRegistered;
                                                            return Container(
                                                                margin: const EdgeInsets.only(right: 10),
                                                                child: Tooltip(
                                                                    message: () {
                                                                        if (status == "present")
                                                                            return "Présent";
                                                                        return "Token à valider";
                                                                    }(),
                                                                    child: Icon(() {
                                                                            if (status == "present")
                                                                                return FontAwesomeIcons.check;
                                                                            return FontAwesomeIcons.question;
                                                                        }(),
                                                                        color: () {
                                                                            if (status == "present")
                                                                                return Colors.green;
                                                                            return Colors.orange;
                                                                        }()
                                                                    ),
                                                                ),
                                                            );
                                                        } catch (ignored) {}

                                                        return Container();
                                                    }(),

                                                    Text(this.widget.scheduleSession.moduleTitle + "\n"
                                                        + this.widget.scheduleSession.activityTitle,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w600
                                                        ),
                                                    ),
                                                ],
                                            ),

                                            Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    width: MediaQuery.of(context).size.width / 2,
                                                    margin: const EdgeInsets.symmetric(vertical: 10),
                                                    child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                            Text(() {
                                                                DateTime startDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                                                                    .parse(this.widget.scheduleSession.start);
                                                                String minutes = (startDate.minute > 9) ? startDate.minute.toString() : "0" + startDate.minute.toString();

                                                                return startDate.hour.toString() + ":" + minutes;
                                                            }(),
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 30,
                                                                    fontWeight: FontWeight.w800
                                                                ),
                                                            ),

                                                            Icon(Icons.arrow_forward,
                                                                color: Colors.white,
                                                                size: 25,
                                                            ),

                                                            Text(() {
                                                                DateTime endDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                                                                    .parse(this.widget.scheduleSession.end);
                                                                String minutes = (endDate.minute > 9) ? endDate.minute.toString() : "0" + endDate.minute.toString();

                                                                return endDate.hour.toString() + ":" + minutes;
                                                            }(),
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 30,
                                                                    fontWeight: FontWeight.w800
                                                                ),
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                alignment: Alignment.centerRight,
                                                child: Text(() {
                                                    String room = "Non définie";
                                                    try {
                                                        room = this.widget.scheduleSession.room.code.substring(
                                                            this.widget.scheduleSession.room.code.lastIndexOf('/') + 1,
                                                            this.widget.scheduleSession.room.code.length) + " - "  +
                                                            this.widget.scheduleSession.numberStudentsRegistered.toString()
                                                                + "/" + this.widget.scheduleSession.room.seats.toString();
                                                    } catch(ignored) {}

                                                    return room;
                                                    }(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                    ),
                                                ),
                                            )
                                        ],
                                    )
                                ),
                            ),
                        )
                    ),
                ),

                () {
                    if (this.widget.scheduleSession.eventRegistered is bool)
                        return Container();

                    return Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                            children: <Widget>[
                                Icon(Icons.check_circle_outline, color: Colors.green),
                                SizedBox(width: 5),
                                Text("Vous êtes inscrit(e) à cette activité.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500
                                    ),
                                )
                            ],
                        ),
                    );
                }(),

                Container(
                    margin: const EdgeInsets.only(left: 15, top: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Container(
                                    child: Text("Professeurs",
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                )
                            ),

                            Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: Row(
                                    children: () {
                                        List<Widget> professors = List<Widget>();

                                        this.widget.scheduleSession.professors.forEach((ScheduleProfessor prof) {
                                            professors.add(Container(
                                                padding: EdgeInsets.only(right: 15),
                                                child: Tooltip(
                                                    message: prof.title == null ? "Inconnu !" : prof.title,
                                                    child: CircleAvatar(
                                                        child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: DecorationImage(
                                                                    fit: BoxFit.cover,
                                                                    image: CachedNetworkImageProvider(this._autolog + "/file/userprofil/" + prof.login.split('@')[0] + ".bmp")
                                                                )
                                                            ),
                                                        ),
                                                    ),
                                                )
                                            ));
                                        });

                                        return professors;
                                    }(),
                                ),
                            ),
                        ],
                    ),
                ),

                // Details of registered users
                Expanded(
                    child: SingleChildScrollView(
                        child: Container(),
                    ),
                )

                /*Container(
                    height: 200,
                    child: Card(
                        child: Column(
                            children: <Widget>[
                                buildInformation(context),
                                Divider(),
                                buildProfessors(context)
                            ],
                        ))),
                Container(
                    child: RaisedButton(
                        onPressed: () {
                            SharedPreferences.getInstance().then((SharedPreferences prefs) {
                                IntranetAPIUtils()
                                    .registerToActivity(
                                    prefs.getString("autolog_url"),
                                    ((this.widget.scheduleSession.scolarYear == null)
                                        ? DateTime.now().year.toString()
                                        : this.widget.scheduleSession.scolarYear),
                                    this.widget.scheduleSession.codeModule,
                                    this.widget.scheduleSession.codeInstance,
                                    this.widget.scheduleSession.codeActivity,
                                    this.widget.scheduleSession.eventRegistered is bool)
                                    .then((dynamic res) {
                                    this.setState(() {});
                                });
                            });
                        },
                        color: (this.widget.scheduleSession.eventRegistered is bool
                            ? Colors.green
                            : Colors.red),
                        child: Text(
                            (this.widget.scheduleSession.eventRegistered is bool
                                ? "S'inscrire"
                                : "X"),
                            style: TextStyle(color: Colors.white),
                        ),
                    ),
                )*/
            ],
        );
    }
}
