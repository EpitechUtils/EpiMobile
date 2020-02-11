import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';
import 'package:mobile_intranet/pages/profile/MarksProfile.dart';
import 'package:mobile_intranet/pages/profile/UserProfile.dart';
import 'package:mobile_intranet/pages/profile/AbsenceProfile.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:mobile_intranet/parser/components/profile/Netsoul/Netsoul.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigurationKeys;
import 'package:mobile_intranet/layouts/default.dart';

/// ProfilePage extended by StatefulWidget
/// Generate state and display widget
class ProfilePage extends StatefulWidget {
    final String title;

    /// Constructor
    ProfilePage({Key key, this.title}) : super(key: key);

    /// Build and display state
    @override
    _ProfilePageState createState() => _ProfilePageState();
}

/// ProfilePage State (with SingleTickerProviderStateMixin)
/// Display profile page
class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {

    TabController _controller;
    SharedPreferences _prefs;
    Profile _profile;
    Netsoul _netsoul;

    _ProfilePageState() {
        // Load shared preferences
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() {
            this._prefs = prefs;
            Parser parser = Parser(prefs.getString("autolog_url"));

            // Parse profile information
            parser.parseProfile(prefs.get("email"))
                .then((Profile profile) => this.setState(() {
                this._profile = profile;
            }));

            parser.parseNetsoul(prefs.get("email"))
                .then((Netsoul netsoul) => this.setState(() {
                this._netsoul = netsoul;
            }));
        }));
    }

    /// When screen start
    @override
    void initState() {
        super.initState();

        // Configure controller for tab controls
        this._controller = TabController(length: 3, vsync: this, initialIndex: 0);
    }

    /// When screen close (dispose)
    @override
    void dispose() {
        this._controller.dispose();
        super.dispose();
    }

    Widget build(BuildContext context) {
        return DefaultLayout(
            notifications: (this._prefs == null) ? 0 : this._prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            bottomAppBar: TabBar(
                controller: this._controller,
                tabs: <Widget>[
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Icon(Icons.person),
                                SizedBox(width: 5),
                                Text("Profile")
                            ],
                        ),
                    ),
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Icon(Icons.edit_attributes),
                                SizedBox(width: 5),
                                Text("Notes")
                            ],
                        ),
                    ),
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Icon(Icons.list),
                                SizedBox(width: 5),
                                Text("Absences")
                            ],
                        ),
                    ),
                ],
            ),
            child: TabBarView(
                controller: this._controller,
                children: (_profile == null || _netsoul == null) ? [0, 1, 2].map((index) => LoaderComponent()).toList() : <Widget>[
                    UserProfile(profile: this._profile, prefs: this._prefs, netsoul: this._netsoul),
                    MarksProfile(profile: this._profile),
                    AbsenceProfile(profile: this._profile)
                ]
            ),
            title: "Profile"
        );
    }
}
