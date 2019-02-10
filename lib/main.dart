import 'package:flutter/material.dart';
import 'views/LoginPage.dart';
import 'views/HomePage.dart';

void main() => runApp(EpitechMobile());

class EpitechMobile extends StatelessWidget {

    // TODO: Change this to simulate login
    bool checkIfUserIsConnected() {
      return (false);
    }

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Epitech Mobile',
            theme: ThemeData(primarySwatch: Colors.indigo),
            home: HomePage(title: "Dashboard"),
            routes: {
                '/login': (context) => LoginPage(title: "Connexion")
            },
            //debugShowCheckedModeBanner: false
        );
    }

}