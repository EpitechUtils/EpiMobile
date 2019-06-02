import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:mobile_intranet/components/GradientComponent.dart';
import 'package:mobile_intranet/parser/components/Profile/Profile.dart';
import 'package:mobile_intranet/parser/components/Profile/Netsoul/Netsoul.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetsoulProfile extends StatelessWidget {

    List<double> data = [7, 3, 9, 1, 9, 4, 7];
    final Profile profile;
    final SharedPreferences prefs;
    final Netsoul netsoul;

    NetsoulProfile({Key key, @required this.prefs, @required this.profile, @required this.netsoul}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[

                // Profile image
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                        children: <Widget>[

                            // Profile image from intranet
                            // TODO: Change address when connection is OK
                            Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    width: 100.0,
                                    height: 100.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage("https://avatars1.githubusercontent.com/u/8271271?s=460&v=4")
                                        )
                                    )
                                ),
                            ),

                            // Other information
                            Container(
                                height: 100,
                                padding: EdgeInsets.all(15),
                                child: Column(
                                    children: <Widget>[

                                        // Name/surname
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Cyril Colinet",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 23,
                                                    fontFamily: "NunitoSans",
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                        )

                                    ],
                                ),
                            )
                        ],
                    ),
                ),

                Container(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Log Netsoul",
                            style: TextStyle(
                                color: Color.fromARGB(255, 53, 53, 53),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NunitoSans",
                            ),
                            textAlign: TextAlign.left,
                        ),
                    ),
                ),

                // Login time
                Row(
                    children: <Widget>[

                        Container(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                title: Text("Last week"),
                                subtitle: Text("78h"),
                                leading: Icon(Icons.access_time,
                                    size: 35,
                                    color: Color.fromARGB(255, 41, 155, 203)
                                ),
                            ),
                        ),

                        Container(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            child: ListTile(
                                title: Text("Log average"),
                                subtitle: Text("78h"),
                                leading: Icon(Icons.group,
                                    size: 35,
                                    color: Color.fromARGB(255, 41, 155, 203)
                                ),
                            ),
                        )

                    ],
                ),

                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Sparkline(
                        data: this.netsoul.time,
                        lineGradient: GradientComponent.green(),
                        fillGradient: GradientComponent.green(),
                        fillMode: FillMode.below,
                        pointsMode: PointsMode.none,
                        pointSize: 7,
                        pointColor: Colors.amber,
                    ),
                )

            ]
        );
    }

}
