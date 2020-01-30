import 'package:flutter/material.dart';
import 'package:calendar_views/day_view.dart';

@immutable
class Event {
    Event({@required this.startMinuteOfDay, @required this.duration, @required this.title,
	@required this.registered, @required this.link});

    final int startMinuteOfDay;
    final int duration;
    final String title;
    final String registered;
    final String link;
}

class ScheduleSessions extends StatefulWidget {
    List<Event> events;

    ScheduleSessions({Key key, @required this.events}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ScheduleSessionsState();
}

class _ScheduleSessionsState extends State<ScheduleSessions> {

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
		color: (event.registered == "false") ? Colors.grey : Colors.lightBlueAccent,
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
	return this.widget.events.map(
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
	).toList();
    }

    @override
    Widget build(BuildContext context) {
        print(this.widget.events);
	return Expanded(
	    child: DayViewEssentials(
		properties: DayViewProperties(
		    days: <DateTime>[DateTime.now()],
		    minimumMinuteOfDay: 8 * 60,
		    maximumMinuteOfDay: 23 * 60
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
