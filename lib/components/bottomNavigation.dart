import 'package:flutter/material.dart';

/// BottomNavigation bar class
class BottomNavigation extends StatelessWidget {

    /// Get color by current route name
    Color getThemeColorByRoute(BuildContext context, String route) {
        if (ModalRoute.of(context).settings.name == route)
            return Colors.white;

        // Not selected
        return Colors.grey;
    }

    /// Build content and display bottom navigation bar
    @override
    Widget build(BuildContext context) {
        return BottomAppBar(
            elevation: 10,
            child: Container(
                color: Theme.of(context).bottomAppBarTheme.color,
                child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.dashboard),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/home'),
                                onPressed: () {
                                    if (ModalRoute.of(context).settings.name != '/home')
                                        Navigator.of(context).pushReplacementNamed('/home');
                                },
                            ),

                            IconButton(
                                icon: Icon(Icons.calendar_today),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/schedule'),
                                onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/schedule");
                                }
                            ),

                            IconButton(
                                icon: Icon(Icons.assignment),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/tests_results'),
                                onPressed: () {
                                    if (ModalRoute.of(context).settings.name != '/tests_results')
                                        Navigator.of(context).pushReplacementNamed('/tests_results');
                                },
                            ),

                            IconButton(
                                icon: Icon(Icons.notifications_active),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/notifications'),
                                onPressed: () {
                                    if (ModalRoute.of(context).settings.name != '/notifications')
                                        Navigator.of(context).pushReplacementNamed('/notifications');
                                },
                            ),

                            IconButton(
                                icon: Icon(Icons.settings),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/settings'),
                                onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/settings");
                                }
                            ),
                        ],
                    ),
                )
            ),
        );
    }
}