import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';
import 'package:mobile_intranet/pages/dashboard/ProjectsDashboard.dart';
import 'package:mobile_intranet/pages/dashboard/RecentDashboard.dart';

class DashboardPage extends StatefulWidget {
    final String title;

    DashboardPage({Key key, this.title}) : super(key: key);

    @override
    _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin {
    SharedPreferences _prefs;
    Dashboard _dashboard;
    Notifications _notifications;
    TabController _controller;

    _DashboardPageState() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() {
            this._prefs = prefs;
            Parser parser = Parser(prefs.getString("autolog_url"));

            parser.parseDashboard().then((Dashboard dashboard) => this.setState(() {
                this._dashboard = dashboard;
            }));

            parser.parseDashboardNotifications().then((Notifications notifications) => this.setState(() {
                this._notifications = notifications;
            }));
        }));
    }

    /// When screen start
    @override
    void initState() {
        super.initState();

        // Configure controller for tab controls
        this._controller = TabController(length: 2, vsync: this, initialIndex: 0);
    }

    /// When screen close (dispose)
    @override
    void dispose() {
        this._controller.dispose();
        super.dispose();
    }

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
                        title: Text(_dashboard == null ? "Loading..." : "Dashboard",
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
                                    icon: Icon(Icons.folder),
                                    text: "Projets",
                                ),
                                Tab(
                                    icon: Icon(Icons.notifications),
                                    text: "Récent",
                                )
                            ],
                        ),
                    ),
                    body: TabBarView(
                        controller: this._controller,
                        children: (_dashboard == null || _notifications == null) ? [0, 1].map((index) => LoaderComponent()).toList() : <Widget>[
                            ProjectsDashboard(dashboard: this._dashboard),
                            RecentDashboard(notifications: this._notifications)
                        ]
                    ),
                    bottomNavigationBar: BottomNavigationComponent()
                ),
            ),
        );
    }

}
