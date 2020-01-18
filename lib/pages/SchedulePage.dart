import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/CalendarComponent.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';

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
                print(this.scheduleDay.sessions[0].toJson());
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

    onSelect(data) {
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

    Widget dateTileBuilder(date, selectedDate, rowIndex, dayName, isDateMarked,
	isDateOutOfRange) {
	bool isSelectedDate = date.compareTo(selectedDate) == 0;
	Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
	TextStyle normalStyle = TextStyle(
	    fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
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

    Widget sessions() {
        if (this.scheduleDay == null)
            return LoaderComponent();
	return ListView.builder(
	    shrinkWrap: true,
	    itemCount: this.scheduleDay.sessions.length,
	    scrollDirection: Axis.vertical,
	    itemBuilder: (BuildContext context, int index) {
	        return Container();
	        /*
	        return Container(
		    child: Card(
			child: Column(
			    mainAxisAlignment: MainAxisAlignment.center,
			    children: <Widget>[
			        Container(
				    child: Text(this.scheduleDay.sessions[index].start.split(' ')[1]),
				),
			        Container(
				    alignment: Alignment.center,
				    child: Text(
					((this.scheduleDay.sessions[index].moduleTitle == null) ? "?" : this.scheduleDay.sessions[index].moduleTitle)
				    + ((this.scheduleDay.sessions[index].title == null) ? "" : " " + this.scheduleDay.sessions[index].title)),
				),
				Container(
				    child: Text(this.scheduleDay.sessions[index].end.split(' ')[1]),
				)
			    ],
			),
		    ),
		);*/
	    },
	);
    }

    /// Display content
    @override
    Widget build(BuildContext context) {
	return Scaffold(
	    appBar: AppBar(
		backgroundColor: Color.fromARGB(255, 41, 155, 203),
		title: Text("Planning",
		    style: TextStyle(
			fontWeight: FontWeight.bold,
			fontFamily: "NunitoSans"
		    ),
		),
		brightness: Brightness.dark,
	    ),
	    body: Container(
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
				    color: Colors.black12),
			    ),
			),
			Expanded(
			    child: SingleChildScrollView(
				scrollDirection: Axis.vertical,
				child: Row(
				    mainAxisAlignment: MainAxisAlignment.start,
				    children: <Widget>[
					Container(
					    width: 50,
					    child: Column(
						children: <Widget>[
						    Text("09:00"),
						    Divider(height: 50),
						    Text("10:00"),
						    Divider(height: 50),
						    Text("11:00"),
						    Divider(height: 50),
						    Text("12:00"),
						    Divider(height: 50),
						    Text("13:00"),
						    Divider(height: 50),
						    Text("14:00"),
						    Divider(height: 50),
						    Text("15:00"),
						    Divider(height: 50),
						    Text("16:00"),
						    Divider(height: 50),
						    Text("17:00"),
						    Divider(height: 50),
						    Text("18:00"),
						    Divider(height: 50),
						    Text("19:00"),
						    Divider(height: 50),
						    Text("20:00"),
						    Divider(height: 50),
						    Text("21:00"),
						],
					    ),
					),
					Container(
					    width: (MediaQuery.of(context).size.width * 0.75),
					    alignment: Alignment.center,
					    child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: <Widget>[
						    Container(
							height: 100,
							child: Card(
							    color: Colors.black12,
							    child: Text("Kick off"),
							),
						    ),
						    Container(
							height: 100,
							child: Card(
							    color: Colors.redAccent,
							    child: Text("Kick off"),
							),
						    ),
						    Container(
							height: 50,
							child: Card(
							    color: Colors.black12,
							    child: Text("Kick off"),
							),
						    ),
						    Container(
							height: 200,
							child: Card(
							    color: Colors.lightGreenAccent,
							    child: Text("Kick off"),
							),
						    ),
						    Container(
							height: 100,
							child: Card(
							    color: Colors.brown,
							    child: Text("Kick off"),
							),
						    ),
						],
					    ),
					),
				    ],
				)
			    )
			)
		    ],
		),
	    ),
	    bottomNavigationBar: BottomNavigationComponent()
	);
    }

}
