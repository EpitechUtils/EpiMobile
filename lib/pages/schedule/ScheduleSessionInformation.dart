import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';

class ScheduleSessionInformation extends StatefulWidget {
    ScheduleSession scheduleSession;

    ScheduleSessionInformation({Key key, @required this.scheduleSession}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionInformation();
}

class _ScheduleSessionInformation extends State<ScheduleSessionInformation> {
    @override
    Widget build(BuildContext context) {
	return Scaffold(
	    appBar: AppBar(
		title: Text(this.widget.scheduleSession.activityTitle),
	    ),
	    body: Container(),
	);
    }
}