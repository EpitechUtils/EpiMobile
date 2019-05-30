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
        //prefs.setString("autolog_url", "https://intra.epitech.eu/auth-9472567ed80878ddb46ac61a97bad16e5e5bd99d");

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
        return SplashScreenDisplay();
    }
}