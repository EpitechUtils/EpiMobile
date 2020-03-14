import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/login/select.dart';
import 'package:mobile_intranet/pages/settings/ScheduleSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigurationKeys;

class SettingsPage extends StatefulWidget {
    final String title;

    /// Constructor
    SettingsPage({Key key, this.title}) : super(key: key);

    /// Build and display state
    @override
    _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    SharedPreferences prefs;

    @override
    void initState() {
	    super.initState();
    }

    @override
    void dispose() {
	    super.dispose();
    }

    Widget createSettingsList(BuildContext context)
    {
        List<String> settings = ["Planning"];

        return ListView.builder(
	    itemCount: settings.length,
	    itemBuilder: (BuildContext context, int index) {
	        return ListTile(
                title: Text(settings[index]),
                leading: Icon(Icons.schedule),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleSettings())),
            );
	    }
	);
    }

    /// Display content
    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
	    notifications: (this.prefs == null) ? 0 : this.prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            title: "Paramètres",
            child: createSettingsList(context),
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.settings_power),
                    tooltip: "Se déconnecter",
                    onPressed: () {
                        SharedPreferences.getInstance().then((prefs) {
                            prefs.clear();

                            // Redirect to selection view
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => SelectLogin(loginEmail: null)
                            ));
                        });
                    },
                ),
            ],
        );
    }

}
