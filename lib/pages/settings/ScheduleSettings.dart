import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigKeys;

class ScheduleSettings extends StatefulWidget {
    /// Constructor
    ScheduleSettings({Key key}) : super(key: key);

    /// Build and display state
    @override
    _ScheduleSettingsState createState() => _ScheduleSettingsState();
}

class _ScheduleSettingsState extends State<ScheduleSettings> {
    SharedPreferences preferences;
    Map<String, bool> scheduleSettingsValues = new Map<String, bool>();

    @override
    void initState() {
	SharedPreferences.getInstance().then((SharedPreferences prefs) {
	    this.setState(() {
		this.preferences = prefs;

		scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_FR] = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_FR);
		scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES] = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES);
		scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS] = prefs.getBool(ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS);
	    });
	});
	super.initState();
    }

    @override
    void dispose() {
	super.dispose();
    }

    Widget displaySettings(BuildContext context)
    {
        if (this.preferences == null) {
            return CircularProgressIndicator();
	}
	return Container(
	    child: Column(
		children: <Widget>[
		    SwitchListTile(
			title: Text("Afficher les activités FR"),
			value: this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_FR],
			onChanged: (bool value) {
			    setState(() {
				this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_FR] = value;
				this.preferences.setBool(ConfigKeys.CONFIG_KEY_SCHEDULE_FR, value);
			    });
			},
		    ),
		    SwitchListTile(
			title: Text("Afficher uniquement les modules où je suis inscris"),
			value: this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES],
			onChanged: (bool value) {
			    setState(() {
				this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES] = value;
				this.preferences.setBool(ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_MODULES, value);
			    });
			},
		    ),
		    SwitchListTile(
			title: Text("Afficher uniquement les sessions où je suis inscris"),
			value: this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS],
			onChanged: (bool value) {
			    setState(() {
				this.scheduleSettingsValues[ConfigKeys.CONFIG_KEY_SCHEDULE_ONLY_REGISTERED_SESSIONS] = value;
			    });
			},
		    ),
		],
	    ),
	);
    }

    Widget build(BuildContext context)
    {
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
		    body: displaySettings(context),
		    bottomNavigationBar: BottomNavigationComponent()
		),
	    ),
	);
    }

}
