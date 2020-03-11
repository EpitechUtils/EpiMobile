import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/bottomNavigation.dart';

/// Header component
/// Must be integrated in all routes
class DefaultLayout extends StatelessWidget {

    // Configure default values
    final String title;
    final Widget child;
    final Widget bottomAppBar;
    final List<Widget> actions;
    final bool hasProfileButton;
    final int notifications;

    // Constructor
    DefaultLayout({@required this.title, @required this.child, this.bottomAppBar, this.actions, this.hasProfileButton = true, this.notifications = 0});

    Widget buildAppBar(BuildContext context) {
        if (this.hasProfileButton) {
            return AppBar(
                actions: this.actions,
                title: Row(
                    children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: InkWell(
                                onTap: () {},
                                child: Icon(Icons.menu,
                                    size: 30,
                                ),
                            ),
                        ),
                        Text(this.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                            ),
                        )
                    ],
                ),
                flexibleSpace: Container(
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
                ),
                centerTitle: false,
                bottom: this.bottomAppBar
            );
        } else {
            return AppBar(
                actions: this.actions,
                title: Text(this.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),
                ),
                flexibleSpace: Container(
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
                ),
                centerTitle: false,
                bottom: this.bottomAppBar
            );
        }
    }

    /// Build header
    @override
    Widget build(BuildContext context) {
        return Container(
            child: SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                    appBar: buildAppBar(context),
                    body: this.child,
                    //bottomNavigationBar: BottomNavigation(notifications: this.notifications)
                ),
            ),
        );
    }
}