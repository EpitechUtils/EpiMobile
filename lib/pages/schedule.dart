import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/CalendarComponent.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigurationKeys;
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/schedule/ScheduleSessions.dart';

class SchedulePage extends StatefulWidget {
    final String title;

    /// Constructor
    SchedulePage({Key key, this.title}) : super(key: key);

    /// Build and display state
    @override
    _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {

    ScheduleDay scheduleDay;
    SharedPreferences prefs;
    DateTime startDate = DateTime.now().subtract(Duration(days: 2));
    DateTime endDate = DateTime.now().add(Duration(days: 30));
    DateTime selectedDate = DateTime.now();

    _SchedulePageState() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() {
            this.prefs = prefs;
            Parser parser = Parser(prefs.get("autolog_url"));

            parser.parseScheduleDay(selectedDate).then((ScheduleDay res) => this.setState(() {
                this.scheduleDay = res;
	    }));
	}));
    }

    @override
    void initState() {
	    super.initState();
    }

    @override
    void dispose() {
	    super.dispose();
    }

    void onSelect(data) {
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
            style: TextStyle(fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontStyle: FontStyle.italic)
            ),
            padding: EdgeInsets.only(top: 8, bottom: 4),
        );
    }

    Widget getMarkedIndicatorWidget() {
	return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
	    Container(
		margin: EdgeInsets.only(left: 1, right: 1),
		width: 7,
		height: 7,
		decoration: BoxDecoration(
		    shape: BoxShape.circle, color: Colors.red),
	    ),
	    Container(
		width: 7,
		height: 7,
		decoration: BoxDecoration(
		    shape: BoxShape.circle, color: Colors.blue),
	    )
	]);
    }

    Widget dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
	bool isSelectedDate = date.compareTo(selectedDate) == 0;
	Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
	TextStyle normalStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
	TextStyle selectedStyle = TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
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

    Widget displaySessions()
    {
        if (this.scheduleDay == null) {
            return Center(
		child: CircularProgressIndicator(),
	    );
	} else {
            return ScheduleSessions(events: this.scheduleDay.sessions);
	}
    }

    /// Display content
    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            notifications: this.prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            title: "Planning",
            child: Container(
                child: Column(
                    children: <Widget>[
                        Container(
                            height: 100,
                            child: CalendarStrip(
                                startDate: startDate,
                                endDate: endDate,
                                onDateSelected: onSelect,
                                dateTileBuilder: dateTileBuilder,
                                iconColor: Colors.lightBlueAccent,
                                monthNameWidget: _monthNameWidget,
                                markedDates: [],
                                containerDecoration: BoxDecoration(
                                    color: Colors.black12
                                ),
                            ),
                        ),
                        displaySessions()
                    ],
                ),
            ),
        );
    }


}
