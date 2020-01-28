import 'package:flutter/material.dart';
import 'package:calendar_views/day_view.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';

@immutable
class Event {
    Event({@required this.startMinuteOfDay, @required this.duration, @required this.title});

    final int startMinuteOfDay;
    final int duration;
    final String title;
}

class ScheduleSessions extends StatefulWidget {
    ScheduleDay day;

    ScheduleSessions({Key key, @required ScheduleDay day}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionsState();
}

class _ScheduleSessionsState extends State<ScheduleSessions> {

    List<Event> eventsOfDay;

    _ScheduleSessionsState() {
        eventsOfDay = new List<Event>();

        for (var elem in this.widget.day.sessions) {
            // Fill events
	}
    }

    Positioned _generatedTimeIndicatorBuilder(BuildContext context, ItemPosition itemPosition, ItemSize itemSize, int minuteOfDay) {
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

    Positioned _generatedSupportLineBuilder(BuildContext context, ItemPosition itemPosition, double itemWidth, int minuteOfDay) {
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

    Positioned _generatedDaySeparatorBuilder(BuildContext context, ItemPosition itemPosition, ItemSize itemSize, int daySeparatorNumber) {
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

    Positioned _eventBuilder(BuildContext context, ItemPosition itemPosition, ItemSize itemSize, Event event) {
	return  Positioned(
	    top: itemPosition.top,
	    left: itemPosition.left,
	    width: itemSize.width,
	    height: itemSize.height,
	    child:  Container(
		margin:  EdgeInsets.only(left: 1.0, right: 1.0, bottom: 1.0),
		padding:  EdgeInsets.all(3.0),
		color: Colors.green[200],
		child:  Text("${event.title}"),
	    ),
	);
    }

    String _minuteOfDayToHourMinuteString(int minuteOfDay) {
	return "${(minuteOfDay ~/ 60).toString().padLeft(2, "0")}"
	    ":"
	    "${(minuteOfDay % 60).toString().padLeft(2, "0")}";
    }

    List<StartDurationItem> _getEventsOfDay(DateTime day) {
	List<Event> events;
	events = eventsOfDay;

	return events
	    .map(
		(event) => new StartDurationItem(
		startMinuteOfDay: event.startMinuteOfDay,
		duration: event.duration,
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

    Widget _headerItemBuilder(BuildContext context, DateTime day) {
	return new Container(
	    color: Colors.grey[300],
	    padding: new EdgeInsets.symmetric(vertical: 4.0),
	    child: new Column(
		children: <Widget>[
		    new Text(
			"${day.weekday}",
			style: new TextStyle(fontWeight: FontWeight.bold),
		    ),
		    new Text("${day.day}"),
		],
	    ),
	);
    }

    @override
    Widget build(BuildContext context) {
	return Expanded(
	    child: DayViewEssentials(
		properties: DayViewProperties(
		    days: <DateTime>[DateTime.now()],
		),
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
