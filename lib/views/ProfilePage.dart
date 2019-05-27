import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ProfilePage extends StatefulWidget {
    ProfilePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                        // Top text
                        Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: Stack(
                                alignment: Alignment.center,
                                children: [

                                    // Background
                                    Container(
                                        height: MediaQuery.of(context).size.height / 6,
                                        child: Stack(
                                            alignment: Alignment.centerLeft,
                                            children: [
                                                Positioned(
                                                    left: -5,
                                                    right: 0,
                                                    child: Image.asset("assets/images/mask-7.png",
                                                        fit: BoxFit.cover,
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),

                                    // Text
                                    Positioned(
                                        left: 20,
                                        top: 80,
                                        child: Container(
                                            height: 40,
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                    Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text("Profile",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 255, 255, 255),
                                                                fontSize: 30,
                                                                fontFamily: "",
                                                            ),
                                                            textAlign: TextAlign.left,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),

                                ],
                            ),
                        ),
                        /*Spacer(),
                        Container(
                            height: 200,
                            child: Stack(
                                alignment: Alignment.center,
                                children: [
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            height: 80,
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
                                        ),
                                    ),
                                ],
                            ),
                        ),*/
                    ],
                ),
            ),
            bottomNavigationBar: Container(
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
                                onPressed: () {
                                    Navigator.of(context).pushReplacementNamed("/home");
                                },
                            )
                        ),

                        // Schedule
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: IconButton(
                                icon: Icon(OMIcons.calendarToday),
                                color: Color.fromARGB(100, 41, 155, 203),
                                iconSize: 24,
                                onPressed: () {},
                            )
                        ),

                        // Profile
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: IconButton(
                                icon: Icon(OMIcons.person),
                                color: Color.fromARGB(255, 41, 155, 203),
                                iconSize: 24,
                                onPressed: () {},
                            )
                        ),

                        // Settings
                        Container(
                            width: MediaQuery.of(context).size.width / 4,
                            child: IconButton(
                                icon: Icon(OMIcons.settings),
                                color: Color.fromARGB(100, 41, 155, 203),
                                iconSize: 24,
                                onPressed: () {},
                            )
                        ),
                    ],
                ),
            )
        );
    }

}
