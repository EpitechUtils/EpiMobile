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
                print(login);

                // Save login email if no error
                if (login == null) {
                    Navigator.of(context).pushReplacementNamed('/error_login');
                    return;
                }

                prefs.setString("email", login);
                Navigator.of(context).pushReplacementNamed('/home');
            });
        });

        return Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor
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