import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Synchronization extends StatelessWidget {

    /// Run async task to change view after given time
    startTime(BuildContext context) async {
        var duration = new Duration(seconds: 4);

        return new Timer(duration, () {
            Navigator.of(context).pushReplacementNamed('/home');
        });
    }

    @override
    Widget build(BuildContext context) {
        this.startTime(context);

        return Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                        SvgPicture.asset("assets/images/icons/sync.svg",
                            width: MediaQuery.of(context).size.width / 2,
                        ),

                        SizedBox(height: 20),

                        Text("Synchronisation...",
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 15),

                        Text("Nous téléchargeons les données qui nous seront utiles "
                            "pour l'utilisation de l'application.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 15.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 30),

                        SpinKitThreeBounce(
                            color: Color(0xFF131313),
                            size: 30,
                        )

                    ],
                ),
            ),
        );
    }

}