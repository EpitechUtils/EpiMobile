import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlots.dart';
import 'package:mobile_intranet/parser/components/subcomponents/registrationSlot/RegistrationSlot.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';


class ScheduleSessionRdv extends StatefulWidget {
    ScheduleSession scheduleSession;
    SharedPreferences preferences;

    ScheduleSessionRdv({Key key, @required this.scheduleSession, @required this.preferences}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionRdv();
}

class _ScheduleSessionRdv extends State<ScheduleSessionRdv> {
    RegistrationSlots slots;
    String slug;
    bool state = true;

    @override
    void initState() {
        super.initState();

	this.slug = "/module/" + ((this.widget.scheduleSession.scolarYear == null) ? DateTime.now().year.toString() : this.widget.scheduleSession.scolarYear) + "/" + this.widget.scheduleSession.codeModule
	    + "/" + this.widget.scheduleSession.codeInstance + "/" + this.widget.scheduleSession.codeActivity + "/rdv";
	Parser(this.widget.preferences.getString("autolog_url")).parseSessionRegistrationSlots(this.slug).then((RegistrationSlots slots) {
	    this.setState(() => this.slots = slots);
	});
    }

    Widget buildRegistrationState(BuildContext context, RegistrationSlot slot)
    {
        if (slot.membersPictures == null) {
            return Container(
		margin: EdgeInsets.only(right: 10, bottom: 3),
		alignment: Alignment.centerRight,
		child: FlatButton(
		    onPressed: () {
		        this.setState(() => this.state = false);
		        IntranetAPIUtils().registerToRdvSlot(this.slug + "/register", this.slots.group.id, slot.idSlot).then((dynamic res) {
		            print(res.toString());
			    this.setState(() => this.state = true);
			});
		    },
		    shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.all(Radius.circular(20)),
		    ),
		    color: Colors.lightBlueAccent,
		    child: Text("S'inscrire", style: TextStyle(color: Colors.white),),
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
		itemBuilder: (context, memberIndex) {
		    return Container(
			margin: EdgeInsets.all(5),
			width: 40.0,
			decoration: BoxDecoration(
			    shape: BoxShape.circle,
			    image: DecorationImage(
				fit: BoxFit.cover,
				image: NetworkImage(this.widget.preferences.getString("autolog_url")
				    + "/file/userprofil/" + membersPicturesArray[memberIndex]
				)
			    )
			)
		    );
		},
		itemCount: slot.membersPictures.split(', ').length,
	    ),
	);

    }

    @override
    Widget build(BuildContext context)
    {
	if (this.slots == null || !this.state) {
	    return Center(child: CircularProgressIndicator());
	}
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
						Text(this.slots.slots[0].blocks[index].date.split(' ')[1], style: TextStyle(fontWeight: FontWeight.w600)),
						Text(" -  " + this.slots.slots[0].blocks[index].duration.toString() + " min")
					    ],
					),
				    ),
				    Container(
					child: buildRegistrationState(context, this.slots.slots[0].blocks[index]),
				    )
				],
			    ),
			),
		    );
		},
	    )
	);
    }
}