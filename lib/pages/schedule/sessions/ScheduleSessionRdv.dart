import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/components/subcomponents/RegistrationSlots.dart';

class ScheduleSessionRdv extends StatefulWidget {
    ScheduleSession scheduleSession;
    SharedPreferences preferences;

    ScheduleSessionRdv({Key key, @required this.scheduleSession, @required this.preferences}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionRdv();
}

class _ScheduleSessionRdv extends State<ScheduleSessionRdv> {
    RegistrationSlots slots;

    @override
    void initState() {
        super.initState();

	String slug = "/module/" + ((this.widget.scheduleSession.scolarYear == null) ? DateTime.now().year.toString() : this.widget.scheduleSession.scolarYear) + "/" + this.widget.scheduleSession.codeModule
	    + "/" + this.widget.scheduleSession.codeInstance + "/" + this.widget.scheduleSession.codeActivity + "/rdv";
	Parser(this.widget.preferences.getString("autolog_url")).parseSessionRegistrationSlots(slug).then((RegistrationSlots slots) {
	    print(slots.slots);
	    this.setState(() => this.slots = slots);
	});
    }

    @override
    Widget build(BuildContext context)
    {
	if (this.slots == null) {
	    return Center(child: CircularProgressIndicator());
	}
	return SafeArea(
	    child: ListView.builder(
		itemCount: this.slots.slots.length,
		itemBuilder: (BuildContext context, int index) {
		    return Container(
			child: Text(this.slots.slots[index].status),
		    );
		},
	    )
	);
    }
}