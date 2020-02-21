import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlots.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlot.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';


class ScheduleSessionNormal extends StatefulWidget {
    ScheduleSession scheduleSession;
    SharedPreferences preferences;

    ScheduleSessionNormal({Key key, @required this.scheduleSession, @required this.preferences}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionNormalState();
}

class _ScheduleSessionNormalState extends State<ScheduleSessionNormal> {

    Widget buildInformation(BuildContext context) {
        return Container(
	    child: Column(
		children: <Widget>[
		    Container(
			margin: EdgeInsets.only(top: 10, bottom: 10),
			child: Container(
			    child: Text("Informations", style: TextStyle(fontWeight: FontWeight.w600),),
			)
		    ),
		    Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children: <Widget>[
			    Container(
				child: Column(
				    children: <Widget>[
					Icon(
					    Icons.people,
					),
					Text(this.widget.scheduleSession.numberStudentsRegistered.toString())
				    ],
				)
			    ),
			    Container(
				child: Column(
				    children: <Widget>[
					Icon(
					    Icons.hourglass_full,
					),
					Text(this.widget.scheduleSession.hoursAmount)
				    ],
				)
			    ),
			    Container(
				child: Column(
				    children: <Widget>[
					Icon(
					    Icons.location_on,
					),
					Text(this.widget.scheduleSession.room.code.substring(this.widget.scheduleSession.room.code.lastIndexOf('/') + 1, this.widget.scheduleSession.room.code.length))
				    ],
				)
			    )
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
			    child: Text("Professeurs", style: TextStyle(fontWeight: FontWeight.w600),),
			)
		    ),
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
						    image: NetworkImage(this.widget.preferences.getString("autolog_url") + "/file/userprofil/" + this.widget.scheduleSession.professors[index].login.split('@')[0] + ".bmp")
						)
					    )
					)
				    )
				);
			    }
			),
		    )
		],
	    ),
	);
    }

    @override
    Widget build(BuildContext context)
    {
	return SafeArea(
	    child: Column(
		children: <Widget>[
		    Container(
			height: 200,
			child: Card(
			    child: Column(
				children: <Widget>[
				    buildInformation(context),
				    Divider(),
				    buildProfessors(context)
				],
			    )
			)
		    ),
		    Container(
			child: RaisedButton(
			    onPressed: () {
				SharedPreferences.getInstance().then((SharedPreferences prefs) {
					IntranetAPIUtils().registerToActivity(
					    prefs.getString("autolog_url"),
					    ((this.widget.scheduleSession.scolarYear == null) ? DateTime.now().year.toString() : this.widget.scheduleSession.scolarYear),
					    this.widget.scheduleSession.codeModule,
					    this.widget.scheduleSession.codeInstance,
					    this.widget.scheduleSession.codeActivity,
					    this.widget.scheduleSession.eventRegistered is bool
					).then((dynamic res) {
					    this.setState(() {});
					});
				});
			    },
			    color: (this.widget.scheduleSession.eventRegistered is bool ? Colors.green : Colors.red),
			    child: Text((this.widget.scheduleSession.eventRegistered is bool ? "S'inscrire" : "X"), style: TextStyle(color: Colors.white),),
			),
		    )
		],
	    )
	);
    }
}