import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/schedule/sessions/scheduleNormalSession.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/pages/schedule/sessions/scheduleMeetingSession.dart';

class ScheduleSessionInformation extends StatefulWidget {
    final ScheduleSession scheduleSession;

    ScheduleSessionInformation({@required this.scheduleSession});

    @override
    State<StatefulWidget> createState() => _ScheduleSessionInformation();
}

class _ScheduleSessionInformation extends State<ScheduleSessionInformation> {

    final String title = "Détails de l'activité";

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: this.title,
            child: () {
                if (this.widget.scheduleSession.typeCode == "rdv") {
                    return ScheduleSessionRdv(
                        scheduleSession: this.widget.scheduleSession,
                        //preferences: this.preferences
                    );
                }

                return ScheduleSessionNormal(
                    scheduleSession: this.widget.scheduleSession,
                    //preferences: this.preferences
                );
            }(),
        );
    }
}
