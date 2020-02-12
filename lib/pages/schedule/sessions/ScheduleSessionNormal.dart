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

    @override
    Widget build(BuildContext context)
    {
	return SafeArea(
	    child: Column(
		children: <Widget>[
		    Container(
			height: 100,
			child: Card(
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
			    )
			)
		    ),
		    Container(
			child: RaisedButton(
			    onPressed: () {

			    },
			    color: (this.widget.scheduleSession.eventRegistered is bool ? Colors.green : Colors.blueGrey),
			    child: Text((this.widget.scheduleSession.eventRegistered is bool ? "S'inscrire" : "X"), style: TextStyle(color: Colors.white),),
			),
		    )
		],
	    )
	);
    }
}