import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/components/calendar/calendar.dart';
import 'package:mobile_intranet/components/loadingComponent.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/schedule/ScheduleSessionInformation.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigKeys;

class SchedulePage extends StatefulWidget {
    final String title;

    /// Constructor
    SchedulePage({Key key, this.title}) : super(key: key);

    /// Build and display state
    @override
    _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {

    List<ScheduleSession> sessions;
    //ScheduleDay scheduleDay;
    //SharedPreferences prefs;
    DateTime selectedDate = DateTime.now();
    List<Meeting> meetings;

    @override
    void initState() {
        super.initState();

        // Get sessions
        this.getAllSessionsFromSelectedDate(this.selectedDate);
    }

    void getAllSessionsFromSelectedDate(DateTime current) {
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
            //this.prefs = prefs;
            Parser parser = Parser(prefs.get("autolog_url"));

            // Get sessions by date
            parser.parseScheduleDay(current).then((ScheduleDay res) => this.setState(() {
                this.sessions = res.sessions;
                this.sessions.removeWhere((event) {
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
            }));
        });
    }

    /*void onSelect(data) {
        this.setState(() {
            this.scheduleDay = null;
        });

        Parser parser = Parser(prefs.get("autolog_url"));
        parser.parseScheduleDay(data).then((ScheduleDay res) => this.setState(() {
            this.scheduleDay = res;
        }));
    }

    Widget _monthNameWidget(monthName) {
        return Container(
            child: Text(monthName,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontStyle: FontStyle.italic)),
            padding: EdgeInsets.only(top: 8, bottom: 4),
        );
    }

    Widget getMarkedIndicatorWidget() {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: EdgeInsets.only(left: 1, right: 1),
                width: 7,
                height: 7,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            ),
            Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            )
        ]);
    }

    Widget dateTileBuilder(
        date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
        bool isSelectedDate = date.compareTo(selectedDate) == 0;
        Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
        TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
        TextStyle selectedStyle = TextStyle(
            fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
        TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
        List<Widget> _children = [
            Text(dayName, style: dayNameStyle),
            Text(date.day.toString(),
                style: !isSelectedDate ? normalStyle : selectedStyle),
        ];

        if (isDateMarked == true) {
            _children.add(getMarkedIndicatorWidget());
        }

        return AnimatedContainer(
            duration: Duration(milliseconds: 150),
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
                color: !isSelectedDate ? Colors.transparent : Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            child: Column(
                children: _children,
            ),
        );
    }

    Widget displaySessions() {
        if (this.scheduleDay == null) {
            return Center(
                child: CircularProgressIndicator(),
            );
        } else {

            return ScheduleSessions(events: this.scheduleDay.sessions);
        }
    }*/

    /// Get color of the session by the typecode
    /// Return [Color]
    Color getSessionColor(ScheduleSession event) {
        switch (event.typeCode) {
            case "rdv":
                return Color(0xFFFF9800);
            case "tp":
                return Color(0xFF9C27B0);
            case "exam":
                return Color(0xFFf44336);
            default:
                return Color(0xFF3F51B5);
        }
    }

    List<Meeting> _getDataSource() {
        List<Meeting> meetings = List<Meeting>();

        this.sessions.forEach((ScheduleSession event) {
            DateTime startTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(event.start);
            DateTime endTime = DateFormat("yyyy-MM-dd HH:mm:ss").parse(event.end);

            // Create metting
            Meeting eventMeeting = Meeting(event.moduleTitle + " - " + event.activityTitle,
                event.room.code.substring(
                    event.room.code.lastIndexOf('/') + 1,
                    event.room.code.length) + " - "  +
                    event.numberStudentsRegistered.toString() + "/" + event.room.seats.toString(),
                startTime, endTime, this.getSessionColor(event), false, event);

            meetings.add(eventMeeting);
        });

        return meetings;
    }

    /// When the current view of the schedule change
    void onViewChanged(ViewChangedDetails details) {
        DateTime selectedDatetime = details.visibleDates[0];
        if (selectedDatetime == null || selectedDatetime == selectedDate)
            return;

        /*this.setState(() {
            this.selectedDate = selectedDatetime;
            this.getAllSessionsFromSelectedDate(selectedDatetime);
        });*/
    }

    /// Display content
    /// Return a [Widget] with the [SfCalendar] material with the events
    @override
    Widget build(BuildContext context) {
        if (this.sessions == null)
            return LoadingComponent(title: "Planning");

        return DefaultLayout(
            //notifications: (this.prefs == null) ? 0 : this.prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            title: "Planning",
            bottomAppBar: PreferredSize(
                preferredSize: Size.fromHeight(30),
                child: Container(
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
                ),
            ),
            child: Container(
                child: SfCalendar(
                    initialSelectedDate: this.selectedDate,
                    onViewChanged: this.onViewChanged,
                    view: CalendarView.day,
                    dataSource: MeetingDataSource(_getDataSource()),
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