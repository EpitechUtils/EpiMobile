import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomNavigationComponent extends StatelessWidget {

    redirectToRoute(BuildContext context, String route) {
        return () {
            debugPrint(ModalRoute.of(context).settings.name + " === " + route);
            if (ModalRoute.of(context).settings.name == route)
                return;

            // Redirect
            Navigator.of(context).pushReplacementNamed(route);
        };
    }

    iconColorFromRoute(BuildContext context, String route) {
        if (ModalRoute.of(context).settings.name == route)
            return Color.fromARGB(255, 41, 155, 203);

        // With small gray trait
        return Color.fromARGB(100, 41, 155, 203);
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 55,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(13, 31, 40, 51),
                        offset: Offset(0, -5),
                        blurRadius: 20,
                    ),
                ],
            ),
            child: Row(
                children: <Widget>[

                    // Dashboard
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.dashboard),
                            color: this.iconColorFromRoute(context, '/home'),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/home')
                        )
                    ),

                    // Schedule
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.calendarToday),
                            color: this.iconColorFromRoute(context, '/schedule'),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/schedule'),
                        )
                    ),

                    // Profile
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.person),
                            color: this.iconColorFromRoute(context, '/profile'),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/profile'),
                        )
                    ),

                    // Settings
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.settings),
                            color: this.iconColorFromRoute(context, '/settings'),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/settings'),
                        )
                    ),
                ],
            ),
        );
    }

}