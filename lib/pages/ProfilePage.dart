import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';
import 'package:mobile_intranet/pages/profile/UserProfile.dart';
import 'package:mobile_intranet/pages/profile/AbsenceProfile.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/Profile/Profile.dart';
import 'package:mobile_intranet/parser/components/Profile/Netsoul/Netsoul.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        title: Text(_profile == null ? "Loading..." : _profile.firstName + " " + _profile.lastName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "NunitoSans"
                            ),
                        ),
                        brightness: Brightness.dark,
                        //centerTitle: false,
                        bottom: TabBar(
                            controller: this._controller,
                            tabs: <Widget>[
                                Tab(
                                    icon: Icon(Icons.person),
                                    text: "Profile",
                                ),
                                Tab(
                                    icon: Icon(Icons.edit_attributes),
                                    text: "Marks",
                                ),
                                Tab(
                                    icon: Icon(Icons.list),
                                    text: "Absences",
                                )
                            ],
                        ),
                    ),
                    body: TabBarView(
                        controller: this._controller,
                        children: _profile == null ? [0, 1, 2].map((index) => LoaderComponent()).toList() : <Widget>[
                            UserProfile(profile: this._profile, prefs: this._prefs, netsoul: this._netsoul),
                            Container(),
                            AbsenceProfile(profile: this._profile)
                        ]
                    ),
                    bottomNavigationBar: BottomNavigationComponent()
                ),
            ),
        );
    }

}
