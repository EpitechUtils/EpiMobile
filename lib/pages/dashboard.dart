import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/bottomNavigation.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:mobile_intranet/components/LoaderComponent.dart';
import 'package:mobile_intranet/pages/dashboard/projectsDashboard.dart';
import 'package:mobile_intranet/pages/dashboard/remindersDashboard.dart';
import 'package:mobile_intranet/pages/dashboard/modulesDashboard.dart';
import 'package:mobile_intranet/parser/components/dashboard/ModuleBoard/ModuleBoard.dart';
import 'package:mobile_intranet/utils/ConfigurationKeys.dart' as ConfigurationKeys;

/// Dashboard Stateful [Widget]
/// Implements the feed of viral images
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

    /// When screen start
    @override
    void initState() {
        super.initState();

        // Configure controller for tab controls
        this._controller = TabController(length: 3, vsync: this, initialIndex: 0);

        // Configure and do requests from API
        this.getInformationsFromAPI();
    }

    /// When screen close (dispose)
    @override
    void dispose() {
        this._controller.dispose();
        super.dispose();
    }

    /// Call intranet API and start parsing
    void getInformationsFromAPI() {
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

    /// Build widget and render application
    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Tableau de Bord",
            notifications: (this._prefs == null) ? 0 : this._prefs.getInt(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_AMOUNT),
            bottomAppBar: TabBar(
                controller: this._controller,
                indicatorColor: Colors.white,
                tabs: <Widget>[
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                Icon(Icons.notifications),
                                SizedBox(width: 5),
                                Text("Alertes",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                )
                            ],
                        ),
                    ),
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Icon(Icons.folder),
                                SizedBox(width: 5),
                                Text("Projets",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                )
                            ],
                        ),
                    ),
                    Tab(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                                Icon(Icons.view_module),
                                SizedBox(width: 5),
                                Text("Modules",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                )
                            ],
                        ),
                    ),
                ],
            ),
            child: TabBarView(
                controller: this._controller,
                children: (_dashboard == null || _notifications == null || _moduleBoard == null) ? [0, 1, 2].map((index) => LoaderComponent()).toList() : <Widget>[
                    ReminderDashboard(dashboard: this._dashboard, moduleBoard: this._moduleBoard),
                    ProjectsDashboard(dashboard: this._dashboard),
                    ModulesDashboard(dashboard: this._dashboard),
                    //RecentDashboard(notifications: this._notifications, prefs: this._prefs),
                ]
            ),
        );
    }

}

