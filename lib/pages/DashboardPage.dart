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
import 'package:mobile_intranet/pages/dashboard/ReminderDashboard.dart';
import 'package:mobile_intranet/pages/dashboard/ModulesDashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';

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
    ModuleBoard _moduleBoard;

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

            var now = DateTime.now();
            var lastDayDateTime = (now.month < 12) ? DateTime(now.year, now.month + 1, 0) : DateTime(now.year + 1, 1, 0);
            parser.parseModuleBoard(now, lastDayDateTime).then((ModuleBoard moduleBoard) => this.setState(() {
                this._moduleBoard = moduleBoard;
            }));
        }));
    }

    /// When screen start
    @override
    void initState() {
        super.initState();

        // Configure controller for tab controls
        this._controller = TabController(length: 4, vsync: this, initialIndex: 0);
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
                        actions: <Widget>[
                            Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(right: 30),
                                child: Icon(
                                    Icons.account_circle,
                                    color: Colors.red,
                                ),
                            )
                        ],
                        brightness: Brightness.dark,
                        //centerTitle: false,
                        bottom: TabBar(
                            controller: this._controller,
                            tabs: <Widget>[
                                Tab(
                                  icon: Icon(Icons.dashboard),
                                    text: "Dashboard",
                                ),
                                Tab(
                                    icon: Icon(Icons.folder),
                                    text: "Projets",
                                ),
                                Tab(
                                    icon: Icon(Icons.beach_access),
                                    text: "Modules",
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
                        children: (_dashboard == null || _notifications == null || _moduleBoard == null) ? [0, 1, 2, 3].map((index) => LoaderComponent()).toList() : <Widget>[
                            ReminderDashboard(dashboard: this._dashboard, moduleBoard: this._moduleBoard),
                            ProjectsDashboard(dashboard: this._dashboard),
                            ModulesDashboard(dashboard: this._dashboard, prefs: this._prefs),
                            RecentDashboard(notifications: this._notifications, prefs: this._prefs),
                        ]
                    ),
                    bottomNavigationBar: BottomNavigationComponent()
                ),
            ),
        );
    }

}
