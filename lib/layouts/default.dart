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

    // Constructor
    DefaultLayout({@required this.title, @required this.child, this.bottomAppBar, this.actions, this.hasProfileButton = true});

    Widget buildAppBar(BuildContext context) {
        if (this.hasProfileButton) {
            return AppBar(
                actions: this.actions,
                leading: IconButton(
                    icon: Icon(Icons.people),
                    tooltip: "Mon profil",
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/profile'),
                ),
                title: Text(this.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                ),
                centerTitle: true,
                bottom: this.bottomAppBar
            );
        } else {
            return AppBar(
                actions: this.actions,
                title: Text(this.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                ),
                centerTitle: true,
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
                    bottomNavigationBar: BottomNavigation()
                ),
            ),
        );
    }
}