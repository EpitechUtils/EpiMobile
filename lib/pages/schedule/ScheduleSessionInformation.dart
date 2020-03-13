import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/schedule/sessions/ScheduleSessionNormal.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/schedule/sessions/ScheduleSessionRdv.dart';

class ScheduleSessionInformation extends StatefulWidget {
    ScheduleSession scheduleSession;

    ScheduleSessionInformation({Key key, @required this.scheduleSession})
        : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionInformation();
}

class _ScheduleSessionInformation extends State<ScheduleSessionInformation> {
    SharedPreferences preferences;

    _ScheduleSessionInformation() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) =>
            this.setState(() => this.preferences = prefs));
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: this.widget.scheduleSession.activityTitle,
            child: buildSessionInformationFromType(context),
        );
    }

    Widget buildSessionInformationFromType(BuildContext context) {
        if (this.preferences == null) {
            return Center(child: CircularProgressIndicator());
        } else if (this.widget.scheduleSession.typeCode == "rdv") {
            return ScheduleSessionRdv(
                scheduleSession: this.widget.scheduleSession,
                preferences: this.preferences
            );
        }

        return ScheduleSessionNormal(
            scheduleSession: this.widget.scheduleSession,
            preferences: this.preferences
        );
    }
}
