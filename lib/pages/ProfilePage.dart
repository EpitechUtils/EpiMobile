import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/GradientComponent.dart';
import 'package:mobile_intranet/components/BottomNavigationComponent.dart';
import 'package:mobile_intranet/components/HeaderComponent.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class ProfilePage extends StatefulWidget {
    ProfilePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    List<double> data;
    Random random = new Random();

    List<double> _generateRandomData(int count) {
        List<double> result = <double>[];
        for (int i = 0; i < count; i++) {
            result.add(random.nextDouble() * 100);
        }
        return result;
    }

    @override
    Widget build(BuildContext context) {
        data = _generateRandomData(7);

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

                        // Header
                        HeaderComponent(title: "Profile"),

                        // Scroller view
                        SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.all(10),
                            child: Column(

                                children: <Widget>[

                                    // Login time
                                    Container(
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [

                                                // Header part
                                                Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text("Logtime",
                                                        style: TextStyle(
                                                            color: Color.fromARGB(255, 53, 53, 53),
                                                            fontSize: 18,
                                                            letterSpacing: -0.3,
                                                            fontWeight: FontWeight.bold,
                                                            fontFamily: "NunitoSans",
                                                        ),
                                                        textAlign: TextAlign.left,
                                                    ),
                                                ),
                                                Sparkline(
                                                    data: data,
                                                    lineGradient: GradientComponent.green(),
                                                    fillMode: FillMode.none,
                                                    pointsMode: PointsMode.all,
                                                    pointSize: 7,
                                                    pointColor: Colors.amber,
                                                ),
                                            ],
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(50)),
                                            color: Colors.white
                                        ),
                                    )
                                ]
                            )
                        )
                    ],
                ),
            ),
            bottomNavigationBar: BottomNavigationComponent()
        );
    }

}
