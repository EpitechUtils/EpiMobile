import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/components/customCircleAvatar.dart';
import 'package:mobile_intranet/components/loadingComponent.dart';
import 'package:mobile_intranet/pages/schedule.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlots.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlot.dart';
import 'package:mobile_intranet/utils/network/intranetAPIUtils.dart';

class ScheduleSessionRdv extends StatefulWidget {
    final ScheduleSession scheduleSession;

    ScheduleSessionRdv({@required this.scheduleSession});

    @override
    State<StatefulWidget> createState() => _ScheduleSessionRdv(this.scheduleSession);
}

class _ScheduleSessionRdv extends State<ScheduleSessionRdv> {

    // Class fields
    RegistrationSlots slots;
    String slug;
    bool state = true;
    ScheduleSession _scheduleSession;
    String _autolog;

    /// Constructor
    _ScheduleSessionRdv(this._scheduleSession);

    /// Init the render window and display all values
    @override
    void initState() {
        super.initState();

        this.slug = "/module/" + ((this._scheduleSession.scolarYear == null)
                ? DateTime.now().year.toString()
                : this._scheduleSession.scolarYear) +
            "/" + this._scheduleSession.codeModule +
            "/" + this._scheduleSession.codeInstance +
            "/" + this._scheduleSession.codeActivity +
            "/rdv";

        SharedPreferences.getInstance().then((prefs) {
            Parser(prefs.getString("autolog_url")).parseSessionRegistrationSlots(this.slug)
                .then((RegistrationSlots slots) {
                    this.setState(() {
                        this._autolog = prefs.getString("autolog_url");
                        this.slots = slots;
                    });
                });
        });
    }

    /// Build all registration states
    Widget buildRegistrationState(BuildContext context, RegistrationSlot slot) {
        if (slot.membersPictures == null) {
            if (!(this._scheduleSession.eventRegistered is bool))
                return Container();

            return Container(
                margin: EdgeInsets.only(right: 10),
                alignment: Alignment.centerRight,
                child: FlatButton(
                    onPressed: () {
                        this.setState(() => this.state = false);
                        IntranetAPIUtils().registerToRdvSlot(this.slug + "/register",
                            this.slots.group.id, slot.idSlot).then((dynamic res) {
                                print(res.toString());
                                this.setState(() => this.state = true);
                            });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    color: Color(0xFF0072ff),
                    child: Text("S'inscrire",
                        style: TextStyle(color: Colors.white),
                    ),
                ),
            );
        }

        var membersPicturesArray = slot.membersPictures.split(', ');
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 50.0,
            alignment: Alignment.centerLeft,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: slot.membersPictures.split(', ').length,
                itemBuilder: (context, memberIndex) {
                    return Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Tooltip(
                            message: membersPicturesArray[memberIndex],
                            child: CustomCircleAvatar(
                                radius: 50,
                                imagePath: this._autolog + "/file/userprofil/" + membersPicturesArray[memberIndex],
                                noPicture: Image.asset("assets/images/icons/nopicture-icon.png"),
                            )
                        )
                    );
                },
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        if (this.slots == null || !this.state || this._autolog == null)
            return LoadingComponent.getBody(context);

        return Column(
            children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 15, top: 25),
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
                                color: SchedulePage.getSessionColor(this._scheduleSession),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(this._scheduleSession.moduleTitle + "\n"
                                                + this._scheduleSession.activityTitle,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600
                                                ),
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
                                                                    .parse(this._scheduleSession.start);
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
                                                                    .parse(this._scheduleSession.end);
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
                                                        room = this._scheduleSession.room.code.substring(
                                                            this._scheduleSession.room.code.lastIndexOf('/') + 1,
                                                            this._scheduleSession.room.code.length) + " - "  +
                                                            this._scheduleSession.numberStudentsRegistered.toString()
                                                            + "/" + this._scheduleSession.room.seats.toString();
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

                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        itemCount: this.slots.slots[0].blocks.length,
                        itemBuilder: (BuildContext context, int index) {
                            return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                    border: Border.all(
                                        color: Color(0xFFABABAB),
                                        width: 1,
                                    )
                                ),
                                margin: const EdgeInsets.only(bottom: 15),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        color: Theme.of(context).cardColor,
                                        child: Container(
                                            child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                            Text(this.slots.slots[0].blocks[index].date.split(' ')[1],
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w600
                                                                ),
                                                            ),

                                                            Container(
                                                                padding: EdgeInsets.only(top: 5),
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: <Widget>[
                                                                        Text("Créneau de " + this.slots.slots[0].blocks[index].duration.toString() + "min"),

                                                                    ],
                                                                ),
                                                            )
                                                        ]
                                                    ),
                                                    Container(
                                                        child: this.buildRegistrationState(
                                                            context, this.slots.slots[0].blocks[index]
                                                        ),
                                                    ),
                                                ],
                                            )
                                        )
                                    )
                                )
                            );
                        },
                    ),
                )
            ],
        );




        return SafeArea(
            child: ListView.builder(
                itemCount: this.slots.slots[0].blocks.length,
                itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: EdgeInsets.all(1),
                        child: Card(
                            child: Column(
                                children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                            children: <Widget>[
                                                Text(this.slots.slots[0].blocks[index].date.split(' ')[1],
                                                    style: TextStyle(fontWeight: FontWeight.w600)),
                                                Text(" -  " +
                                                    this
                                                        .slots
                                                        .slots[0]
                                                        .blocks[index]
                                                        .duration
                                                        .toString() +
                                                    " min")
                                            ],
                                        ),
                                    ),
                                    Container(
                                        child: buildRegistrationState(
                                            context, this.slots.slots[0].blocks[index]),
                                    )
                                ],
                            ),
                        ),
                    );
                },
            ));
    }
}
