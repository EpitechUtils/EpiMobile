import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';
import 'package:mobile_intranet/pages/profile/MarksProfile.dart';
import 'package:mobile_intranet/pages/profile/UserProfile.dart';
import 'package:mobile_intranet/pages/profile/AbsenceProfile.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/Profile/Profile.dart';
import 'package:mobile_intranet/parser/components/Profile/Netsoul/Netsoul.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
    final String title;

    /// Constructor
    SettingsPage({Key key, this.title}) : super(key: key);

    /// Build and display state
    @override
    _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {

    @override
    void initState() {
	super.initState();
    }

    @override
    void dispose() {
	super.dispose();
    }

    /// Display content
    @override
    Widget build(BuildContext context) {
	return Container(
	    color: Color.fromARGB(255, 255, 255, 255),
	    child: SafeArea(
		top: false,
		bottom: false,
		child: Scaffold(
		    appBar: AppBar(
			backgroundColor: Color.fromARGB(255, 41, 155, 203),
			title: Text("Settings",
			    style: TextStyle(
				fontWeight: FontWeight.bold,
				fontFamily: "NunitoSans"
			    ),
			),
			brightness: Brightness.dark,
		    ),
		    body: Text("Hello"),
		    bottomNavigationBar: BottomNavigationComponent()
		),
	    ),
	);
    }

}
