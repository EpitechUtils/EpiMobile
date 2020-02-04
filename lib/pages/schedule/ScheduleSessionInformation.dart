import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/schedule/sessions/ScheduleSessionRdv.dart';

class ScheduleSessionInformation extends StatefulWidget {
    ScheduleSession scheduleSession;

    ScheduleSessionInformation({Key key, @required this.scheduleSession}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionInformation();
}

class _ScheduleSessionInformation extends State<ScheduleSessionInformation> {
    SharedPreferences preferences;

    _ScheduleSessionInformation() {;
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() => this.preferences = prefs));
    }

    @override
    Widget build(BuildContext context)
    {
	return Scaffold(
	    appBar: AppBar(
		title: Text(this.widget.scheduleSession.activityTitle),
	    ),
	    body: buildSessionInformationFromType(context),
	);
    }

    Widget buildSessionInformationFromType(BuildContext context)
    {
        if (this.preferences == null) {
            return Center(child: CircularProgressIndicator());
	}
        switch (this.widget.scheduleSession.typeCode) {
	    case "rdv":
		return ScheduleSessionRdv(scheduleSession: this.widget.scheduleSession, preferences: this.preferences);
	}
    }
}