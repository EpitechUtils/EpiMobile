import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomNavigationComponent extends StatelessWidget {

    redirectToRoute(BuildContext context, String route) {
        return () {
            if (ModalRoute.of(context).settings.name == route)
                return;

            // Redirect
            Navigator.of(context).pushReplacementNamed(route);
        };
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
                            color: Color.fromARGB(100, 41, 155, 203),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/home')
                        )
                    ),

                    // Schedule
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.calendarToday),
                            color: Color.fromARGB(100, 41, 155, 203),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/schedule'),
                        )
                    ),

                    // Profile
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.person),
                            color: Color.fromARGB(255, 41, 155, 203),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/profile'),
                        )
                    ),

                    // Settings
                    Container(
                        width: MediaQuery.of(context).size.width / 4,
                        child: IconButton(
                            icon: Icon(OMIcons.settings),
                            color: Color.fromARGB(100, 41, 155, 203),
                            iconSize: 24,
                            onPressed: this.redirectToRoute(context, '/settings'),
                        )
                    ),
                ],
            ),
        );
    }

}