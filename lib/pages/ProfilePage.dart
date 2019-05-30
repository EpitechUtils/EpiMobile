import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/pages/profile/NetsoulProfile.dart';
import 'package:mobile_intranet/pages/profile/UserProfile.dart';

/// ProfilePage extended by StatefulWidget
///
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

    /// When screen start
    @override
    void initState() {
        super.initState();
        this._controller = TabController(length: 4, vsync: this, initialIndex: 0);
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
                        title: Text("Cyril Colinet", // TODO(cyrilcolinet): Change this
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
                                    icon: Icon(Icons.show_chart),
                                    text: "Login time",
                                ),
                                Tab(
                                    icon: Icon(Icons.edit_attributes),
                                    text: "Marks",
                                ),
                                Tab(
                                    icon: Icon(Icons.list),
                                    text: "Absences",
                                ),
                            ],
                        ),
                    ),
                    body: TabBarView(
                        controller: this._controller,
                        children: <Widget>[

                            // Profile
                            UserProfile(),

                            // Netsoul logs
                            NetsoulProfile(),

                            // Marks
                            Container(),

                            // Absences
                            Container()
                        ],
                    ),
                    bottomNavigationBar: BottomNavigationComponent()
                ),
            ),
        );
    }

}
