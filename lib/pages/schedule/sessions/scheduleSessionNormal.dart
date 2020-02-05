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
    State<StatefulWidget> createState() => _ScheduleSessionNormal();
}

class _ScheduleSessionNormal extends State<ScheduleSessionNormal> {

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Container();
    }
}