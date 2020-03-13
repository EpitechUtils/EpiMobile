import 'package:flutter/material.dart';
import 'package:calendar_views/day_view.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/pages/schedule/ScheduleSessionInformation.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigKeys;

class ScheduleSessions extends StatefulWidget {
    List<ScheduleSession> events;

    ScheduleSessions({Key key, @required this.events}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionsState();
}

class _ScheduleSessionsState extends State<ScheduleSessions> {
    SharedPreferences preferences;

    @override
    void initState() {
        super.initState();
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
            this.setState(() {
                this.preferences = prefs;
                this.widget.events.removeWhere((event) {
                    if (event.codeInstance.contains("FR") &&
                        !this.preferences.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_FR))
                        return true;
                    if (!event.moduleRegistered &&
                        this.preferences.getBool(
                            ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES))
                        return true;
                    if (!(event.eventRegistered is bool) &&
                        this.preferences.getBool(
                            ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS))
                        return true;
                    return false;
                });
            });
        });
    }

    Positioned _generatedTimeIndicatorBuilder(BuildContext context,
        ItemPosition itemPosition, ItemSize itemSize, int minuteOfDay) {
        return Positioned(
            top: itemPosition.top,
            left: itemPosition.left,
            width: itemSize.width,
            height: itemSize.height,
            child: Container(
                child: Center(
                    child: Text(_minuteOfDayToHourMinuteString(minuteOfDay)),
                ),
            ),
        );
    }

    Positioned _generatedSupportLineBuilder(BuildContext context,
        ItemPosition itemPosition, double itemWidth, int minuteOfDay) {
        return Positioned(
            top: itemPosition.top,
            left: itemPosition.left,
            width: itemWidth,
            child: Container(
                height: 0.7,
                color: Colors.grey[700],
            ),
        );
    }

    Positioned _generatedDaySeparatorBuilder(BuildContext context,
        ItemPosition itemPosition, ItemSize itemSize, int daySeparatorNumber) {
        return Positioned(
            top: itemPosition.top,
            left: itemPosition.left,
            width: itemSize.width,
            height: itemSize.height,
            child: Center(
                child: Container(
                    width: 0.7,
                    color: Colors.grey,
                ),
            ),
        );
    }

    Color getSessionColor(ScheduleSession session) {
        switch (session.typeCode) {
            case "rdv":
                return Color.fromRGBO(226, 170, 85, 1);
            case "tp":
                return Color.fromRGBO(164, 140, 187, 1);
            case "exam":
                return Color.fromRGBO(221, 148, 115, 1);
            case "class":
                return Color.fromRGBO(102, 140, 179, 1);
        }
        return Color.fromRGBO(102, 140, 179, 1);
    }

    Positioned _eventBuilder(BuildContext context, ItemPosition itemPosition,
        ItemSize itemSize, ScheduleSession event) {
        return Positioned(
            top: itemPosition.top,
            left: itemPosition.left,
            width: itemSize.width,
            height: itemSize.height,
            child: InkWell(
                child: Stack(
                    children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 1.0, right: 1.0, bottom: 1.0),
                            padding: EdgeInsets.all(3.0),
                            color: getSessionColor(event),
                            width: itemSize.width,
                            height: itemSize.height,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Flexible(
                                        child: Text(
                                            event.moduleTitle + " - " + event.activityTitle,
                                            style: TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    )
                                ],
                            )),
                        Container(
                            alignment: Alignment.bottomRight,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    Flexible(
                                        child: Text(
                                            event.room.code.substring(
                                                event.room.code.lastIndexOf('/') + 1,
                                                event.room.code.length) +
                                                " - ",
                                            style: TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                        )),
                                    Flexible(
                                        child: Text(
                                            event.numberStudentsRegistered.toString() +
                                                "/" +
                                                event.room.seats.toString() +
                                                "  ",
                                            style: TextStyle(color: Colors.white),
                                            overflow: TextOverflow.ellipsis,
                                        ),
                                    ),
                                    /*
				    Container(
					child: Icon(
					    (event.eventRegistered is bool) ? Icons.person : Icons.check,
					    color: (event.eventRegistered is bool) ? Colors.white : Colors.lightGreenAccent,
					),
				    )*/
                                ],
                            ))
                    ],
                ),
                onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ScheduleSessionInformation(scheduleSession: event)));
                },
            ));
    }

    String _minuteOfDayToHourMinuteString(int minuteOfDay) {
        return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
            ":"
            "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
    }

    List<StartDurationItem> _getEventsOfDay(DateTime day) {
        if (this.widget.events == null) {
            return new List<StartDurationItem>();
        }
        return this
            .widget
            .events
            .map(
                (event) => new StartDurationItem(
                startMinuteOfDay:
                DateFormat("yyyy-MM-dd HH:mm:ss").parse(event.start).hour * 60,
                duration: DateFormat("HH:mm:ss").parse(event.hoursAmount).hour * 60,
                builder: (context, itemPosition, itemSize) => _eventBuilder(
                    context,
                    itemPosition,
                    itemSize,
                    event,
                ),
            ),
        )
            .toList();
    }

    @override
    Widget build(BuildContext context) {
        if (this.preferences == null) {
            return Center(
                child: CircularProgressIndicator(),
            );
        }
        return Expanded(
            child: DayViewEssentials(
                properties: DayViewProperties(
                    days: <DateTime>[DateTime.now()],
                    minimumMinuteOfDay: 8 * 60,
                    maximumMinuteOfDay: 23 * 60),
                child: Column(
                    children: <Widget>[
                        Expanded(
                            child: SingleChildScrollView(
                                child: DayViewSchedule(
                                    heightPerMinute: 1.0,
                                    components: <ScheduleComponent>[
                                        TimeIndicationComponent.intervalGenerated(
                                            generatedTimeIndicatorBuilder:
                                            _generatedTimeIndicatorBuilder,
                                        ),
                                        SupportLineComponent.intervalGenerated(
                                            generatedSupportLineBuilder: _generatedSupportLineBuilder,
                                        ),
                                        DaySeparationComponent(
                                            generatedDaySeparatorBuilder:
                                            _generatedDaySeparatorBuilder,
                                        ),
                                        EventViewComponent(
                                            getEventsOfDay: _getEventsOfDay,
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
