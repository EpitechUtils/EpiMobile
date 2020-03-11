import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Synchronization extends StatelessWidget {

    /// Render widget
    @override
    Widget build(BuildContext context) {
        SharedPreferences.getInstance().then((prefs) {
            // Get login by autolog
            IntranetAPIUtils.internal().getLoggedUserEmail(prefs.getString("autolog_url")).then((login) {
                // Save login email if no error
                if (login == null) {
                    Navigator.of(context).pushReplacementNamed('/error_login');
                    return;
                }

                prefs.setString("email", login);
                Timer(Duration(seconds: 4),
                    () => Navigator.of(context).pushReplacementNamed('/home'));
            });
        });

        return Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
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
                                color: Colors.white,
                                fontSize: 25.0,
                                //fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 15),

                        Text("Nous téléchargeons les données qui nous seront utiles "
                            "pour l'utilisation de l'application.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                //fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 30),

                        SpinKitThreeBounce(
                            color: Colors.white,
                            size: 30,
                        )

                    ],
                ),
            ),
        );
    }

}