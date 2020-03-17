import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/components/calendar/calendar.dart';
import 'package:mobile_intranet/components/loadingComponent.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/schedule/scheduleSessionInformation.dart';
import 'package:mobile_intranet/pages/schedule/filters/scheduleFilter.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/configKey.dart' as ConfigKeys;

class SchedulePage extends StatefulWidget {
    final String title;

    /// Constructor
    SchedulePage({Key key, this.title}) : super(key: key);

    /// Get color of the session by the typecode
    /// Return [Color]
    static Color getSessionColor(ScheduleSession event) {
        Color color;

        switch (event.typeCode) {
            case "rdv":
                color =  Color(0xFFFF9800);
                break;
            case "tp":
                color =  Color(0xFF9C27B0);
                break;
            case "exam":
                color =  Color(0xFFf44336);
                break;
            default:
                color = Color(0xFF3F51B5);
                break;
        }

        // Apply oppacity
        color = color.withOpacity(.6);

        // Check user registration
        if (!(event.eventRegistered is bool))
            color = color.withOpacity(1);
        return color;
    }

    /// Build and display state
    @override
    _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

    List<ScheduleSession> sessions;
    DateTime selectedDate;
    List<Meeting> meetings;
    DateHeader dateHeaderWidget;

    @override
    void initState() {
        super.initState();

        // Get sessions
        this.selectedDate = DateTime.now();
        this.getAllSessionsFromSelectedDate(this.selectedDate)
            .then((sessionsList) => this.setState(() => this.sessions = sessionsList));
    }

    Future<List<ScheduleSession>> getAllSessionsFromSelectedDate(DateTime current, {bool forceRefresh = false}) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Parser parser = Parser(prefs.get("autolog_url"));

        // Get sessions by date
        ScheduleDay res = await parser.parseScheduleMonths(current.subtract(Duration(days: 15)), current.add(Duration(days: 15)), forceRefresh: forceRefresh);
        List<ScheduleSession> sessions = res.sessions;
        sessions.removeWhere((event) {
            bool keyFr = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_FR),
                registeredModulesOnly = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES),
                registeredEventsOnly = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS);

            if (event.codeInstance.contains("FR") && (keyFr != null && !keyFr)) {
                return true;
            } else if (!event.moduleRegistered && (registeredModulesOnly != null && registeredModulesOnly)) {
                return true;
            } else if (!(event.eventRegistered is bool) && (registeredEventsOnly != null && registeredEventsOnly)) {
                return true;
            }
            return false;
        });

        return sessions;
    }

    List<Meeting> getEpitechEventsDatasource() {
        List<Meeting> meetings = List<Meeting>();
        if (this.sessions == null)
            return List<Meeting>();

        this.sessions.forEach((ScheduleSession event) {
            DateTime startTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(event.start);
            DateTime endTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(event.end);

            // Parse room
            String room = "Non définie";
            try {
                room = event.room.code.substring(
                    event.room.code.lastIndexOf('/') + 1,
                    event.room.code.length) + " - "  +
                    event.numberStudentsRegistered.toString() + "/" + event.room.seats.toString();
            } catch(ignored) {}

            // Create metting
            Meeting eventMeeting = Meeting(event.moduleTitle + " - " + event.activityTitle,
                room, startTime, endTime, SchedulePage.getSessionColor(event), false, event);

            meetings.add(eventMeeting);
        });

        return meetings;
    }

    /// When the current view of the schedule change
    void onViewChanged(ViewChangedDetails details) {
        DateTime selectedDatetime = details.visibleDates[0];
        if (selectedDatetime == null
            || DateFormat("yyyy-MM-dd").format(selectedDatetime) == DateFormat("yyyy-MM-dd").format(selectedDate))
            return;

        SchedulerBinding.instance.addPostFrameCallback((callback) {
            this.selectedDate = selectedDatetime;
            this.dateHeaderWidget.state.changeSelectedDate(selectedDatetime);
        });

    }

    /// Display content
    /// Return a [Widget] with the [SfCalendar] material with the events
    @override
    Widget build(BuildContext context) {
        if (this.sessions == null)
            return LoadingComponent(title: "Planning");

        this.dateHeaderWidget = DateHeader();
        return DefaultLayout(
            //notifications: (this.prefs == null) ? 0 : this.prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            title: "Planning",
            actions: <Widget>[
                InkWell(
                    onTap: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            context: context,
                            builder: (BuildContext context) {
                                return Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: ScheduleFilter(),
                                );
                            }
                        ).whenComplete(() {
                            //this.setState(() => this.sessions = null);
                            this.getAllSessionsFromSelectedDate(this.selectedDate, forceRefresh: true)
                                .then((sessionsList) => this.setState(() => this.sessions = sessionsList));
                        });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: Icon(FontAwesomeIcons.filter,
                            color: Colors.white,
                            size: 20,
                        )
                    )
                )
            ],
            bottomAppBar: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: this.dateHeaderWidget
            ),
            child: Container(
                child: SfCalendar(
                    //initialSelectedDate: this.selectedDate,
                    onViewChanged: this.onViewChanged,
                    view: CalendarView.day,
                    dataSource: MeetingDataSource(getEpitechEventsDatasource()),
                    onTap: (CalendarTapDetails details) {
                        List<dynamic> appointmentsList = details.appointments;
                        if (appointmentsList == null)
                            return;

                        // Get meeting 0
                        Meeting meeting = appointmentsList[0];
                        if (meeting == null)
                            return;

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ScheduleSessionInformation(scheduleSession: meeting.event
                            )
                        ));
                    },
                    viewHeaderHeight: 0,
                    headerHeight: 0,
                    todayHighlightColor: Color(0xFF0072ff),
                    backgroundColor: Colors.white,
                    timeSlotViewSettings: TimeSlotViewSettings(
                        startHour: 7,
                        timeFormat: "Hm"
                    ),
                    monthViewSettings: MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                    ),
                ),
            ),
        );
    }
}

class MeetingDataSource extends CalendarDataSource {
    MeetingDataSource(List<Meeting> source){
        appointments = source;
    }

    @override
    DateTime getStartTime(int index) {
        return appointments[index].from;
    }

    @override
    String getLocation(int index) {
        return appointments[index].notes;
    }

    @override
    DateTime getEndTime(int index) {
        return appointments[index].to;
    }

    @override
    String getSubject(int index) {
        return appointments[index].eventName;
    }

    @override
    Color getColor(int index) {
        return appointments[index].background;
    }

    @override
    bool isAllDay(int index) {
        return appointments[index].isAllDay;
    }
}

class Meeting {
    Meeting(this.eventName, this.notes, this.from, this.to, this.background, this.isAllDay, this.event);

    String eventName;
    String notes;
    DateTime from;
    DateTime to;
    Color background;
    bool isAllDay;
    ScheduleSession event;
}

class DateHeader extends StatefulWidget {

    final DateHeaderState state = DateHeaderState();

    DateHeaderState createState() => this.state;
}

class DateHeaderState extends State<DateHeader> {

    DateTime selectedDate;

    @override
    void initState() {
        super.initState();
        this.selectedDate = DateTime.now();
    }

    void changeSelectedDate(DateTime newDate) {
        this.setState(() {
            this.selectedDate = newDate;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.only(left: 18, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(DateFormat("d MMMM y").format(this.selectedDate).toString(),
                style: TextStyle(
                    fontFamily: "Sarabun",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17
                ),
            )
        );
    }
}