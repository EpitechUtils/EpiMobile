import 'package:flutter/material.dart';

/// BottomNavigation bar class
class BottomNavigation extends StatelessWidget {
    final int notifications;

    BottomNavigation({this.notifications = 0});

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
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                            Color(0xFF0072ff),
                            Color(0xFF2F80ED),
                        ]
                    )
                ),
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

                        Stack(
                            children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.notifications),
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    color: this.getThemeColorByRoute(context, '/notifications'),
                                    onPressed: () {
                                        if (ModalRoute.of(context).settings.name != '/notifications')
                                            Navigator.of(context).pushReplacementNamed('/notifications');
                                    },
                                ),
                                Positioned(
                                    right: 11,
                                    top: 11,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(6),
                                        ),
                                        constraints: BoxConstraints(
                                            minWidth: 14,
                                            minHeight: 14,
                                        ),
                                        child: Text(
                                            this.notifications.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                )
                            ],
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
            ),
        );
    }
}