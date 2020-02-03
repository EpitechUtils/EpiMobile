import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {

    // Class variables
    final Widget child;
    final Function floatingMethod;

    /// CustomBottomNavigationBar constructor
    BottomNavigation({@required this.child, this.floatingMethod});

    Color getThemeColorByRoute(BuildContext context, String route) {
        if (ModalRoute.of(context).settings.name == route)
            return Theme.of(context).focusColor;

        // Not selected
        return Theme.of(context).disabledColor;
    }

    Widget displayBottomNavigationBar(BuildContext context) {
        return BottomAppBar(
            elevation: 10,
            child: Container(
                color: Theme.of(context).bottomAppBarColor,
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
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
                                color: this.getThemeColorByRoute(context, '/planning'),
                                onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/planning");
                                }
                            ),

                            IconButton(
                                icon: Icon(Icons.people),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                color: this.getThemeColorByRoute(context, '/profile'),
                                onPressed: () {
                                    if (ModalRoute.of(context).settings.name != '/profile')
                                        Navigator.of(context).pushReplacementNamed('/profile');
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

    /// Build content and display bottom navigation bar
    @override
    Widget build(BuildContext context) {
        return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
                bottom: false,
                child: Scaffold(
                    bottomNavigationBar: this.displayBottomNavigationBar(context),
                    body: this.child,
                ),
            ),
        );
    }
}