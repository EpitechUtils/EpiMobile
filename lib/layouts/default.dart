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

    // Constructor
    DefaultLayout({@required this.title, @required this.child, this.bottomAppBar, this.actions});

    /// Build header
    @override
    Widget build(BuildContext context) {
        return Container(
            child: SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                    appBar: AppBar(
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
                    ),
                    body: this.child,
                    bottomNavigationBar: BottomNavigation()
                ),
            ),
        );
    }
}