import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomNavigationComponent extends StatelessWidget {

    Widget iconButtonFromRoute(BuildContext context, IconData def, IconData active, String route) {
        if (ModalRoute.of(context).settings.name == route) {
            return IconButton(
                icon: Icon(active,
                    color: Color.fromARGB(255, 41, 155, 203),
                ),
                iconSize: 24,
                onPressed: null,
            );
        }

        return IconButton(
            icon: Icon(def,
                color: Color.fromARGB(100, 41, 155, 203),
            ),
            iconSize: 24,
            onPressed: () {
                Navigator.of(context).pushReplacementNamed(route);
            },
        );
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            height: Platform.isIOS ? 70 : 55,
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
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: this.iconButtonFromRoute(context, OMIcons.dashboard, Icons.dashboard, "/home")
                        ),
                    ),

                    // Schedule
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: this.iconButtonFromRoute(context, OMIcons.calendarToday, Icons.calendar_today, "/schedule")
                        ),
                    ),

                    // Profile
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: this.iconButtonFromRoute(context, OMIcons.person, Icons.person, "/profile")
                        )
                    ),

                    // Settings
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: this.iconButtonFromRoute(context, OMIcons.settings, Icons.settings, "/settings")
                        ),
                    ),
                ],
            ),
        );
    }

}