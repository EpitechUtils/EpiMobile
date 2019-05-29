import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:mobile_intranet/pages/LoginWebview.dart';
import 'package:mobile_intranet/pages/display/SplashScreenDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SplashScreen extended from StatefulWidget
/// State
class SplashScreen extends StatefulWidget {
    @override
    _SplashScreenState createState() => _SplashScreenState();
}

/// _SplashScreenState extended from State<SplashScreen>
/// Display content
class _SplashScreenState extends State<SplashScreen> {

    final IntranetAPIUtils _api = new IntranetAPIUtils();

    /// Run async task to change view after given time
    startTime() async {
        var duration = new Duration(seconds: 4);
        return new Timer(duration, checkUserLogged);
    }

    /// Check if the user is connected, and redirect to correct home
    checkUserLogged() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // TODO: To remove debugger
        //prefs.remove("autolog_url");

        // Check if autologin url exists in shared preferences and redirect to homepage
        if (prefs.getString("autolog_url") != null)
            return Navigator.of(context).pushReplacementNamed('/home');

        // Ask intranet to give authentication URL
        var authURI = await this._api.getAuthURL().then((auth) {
            if (auth == null || auth['office_auth_uri'] == null) {
                // TODO: Display no connection banner
                return null;
            }

            // Return login URI
            return auth['office_auth_uri'];
        });

        // Not logged, need to redirect to SSO page
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginWebview(authUrl: authURI)
        ));
    }

    /// Init state of the widget and start timer
    @override
    void initState() {
        super.initState();
        this.startTime();
    }

    /// Build widget and display content
    @override
    Widget build(BuildContext context) {
        return Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Stack(
                alignment: Alignment.center,
                children: [

                    // Background
                    Positioned(
                        left: 6,
                        right: 6,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [

                                Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Opacity(
                                        opacity: 0.3,
                                        child: Image.asset(
                                            "assets/images/love--chat-3.png",
                                            fit: BoxFit.cover,
                                        ),
                                    ),
                                )

                            ],
                        ),
                    ),

                    // Logo
                    Positioned(
                        child: Container(
                            width: 305,
                            height: 140,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [

                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment(0.92, 1.1),
                                                    end: Alignment(0.27, 0.46),
                                                    stops: [
                                                        0,
                                                        1,
                                                    ],
                                                    colors: [
                                                        Color.fromARGB(255, 26, 204, 180),
                                                        Color.fromARGB(255, 41, 155, 203),
                                                    ],
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                            ),
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                    Container(
                                                        margin: EdgeInsets.only(right: 19),
                                                        child: Text(
                                                            "E",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 248, 248, 248),
                                                                fontSize: 40,
                                                                fontFamily: "takota",
                                                            ),
                                                            textAlign: TextAlign.left,
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ),

                                    // Spacer
                                    Spacer(),

                                    // Text logo
                                    Container(
                                        height: 70,
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                                Positioned(
                                                    bottom: 0,
                                                    child: Container(
                                                        child: Text(
                                                            "EpiMobile",
                                                            style: TextStyle(
                                                                color: Color.fromARGB(255, 42, 153, 204),
                                                                fontSize: 55,
                                                                letterSpacing: 1.12,
                                                                fontFamily: "takota",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                        ),
                                                    ),
                                                ),
                                            ],
                                        ),
                                    ),

                                ],
                            ),
                        ),
                    ),

                ],
            ),
        );
    }
}