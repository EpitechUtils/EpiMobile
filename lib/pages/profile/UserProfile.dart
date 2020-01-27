import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:mobile_intranet/components/GradientComponent.dart';
import 'package:mobile_intranet/parser/components/profile/Netsoul/Netsoul.dart';

/// UserProfile state ful creator
/// Create state and interact with him
class UserProfile extends StatefulWidget {
    final Profile profile;
    final SharedPreferences prefs;
    final Netsoul netsoul;

    /// Constructor
    UserProfile({Key key, @required this.prefs, @required this.profile, @required this.netsoul}) : super(key: key);

    /// Creating state
    _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {

    @override
    Widget build(BuildContext context) {
        return Column(
            children: <Widget>[
                // Header top profile
                Container(
                    decoration: new BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(50, 31, 40, 51),
                                offset: Offset(-5, 0),
                                blurRadius: 20,
                            )
                        ],
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            repeat: ImageRepeat.repeat,
                            image: AssetImage("assets/images/background.png")
                        )
                    ),
                    child: Row(
                        children: <Widget>[
                            // Profile image from intranet
                            // TODO: Change address when connection is OK
                            Container(
                                padding: EdgeInsets.all(20),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(this.widget.prefs.getString("autolog_url") + this.widget.profile.pictureUrl)
                                            )
                                        )
                                    ),
                                ),
                            ),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Column(
                                    children: <Widget>[
                                        Container(
                                            child: Text.rich(
                                                TextSpan(
                                                    text: "Crédits\t",
                                                    style: TextStyle(fontFamily: "NunitoSans"),
                                                    children: <TextSpan>[
                                                        TextSpan(
                                                            text: this.widget.profile.credits.toString(),
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "NunitoSans")
                                                        )]
                                                )
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: Text.rich(
                                                TextSpan(
                                                    text: "GPA\t",
                                                    style: TextStyle(fontFamily: "NunitoSans"),
                                                    children: <TextSpan>[
                                                        TextSpan(
                                                            text: this.widget.profile.gpa[0]["gpa"].toString(),
                                                            style: TextStyle(fontWeight: FontWeight.bold)
                                                        ),
                                                        TextSpan(
                                                            text: "\t(cycle " + this.widget.profile.gpa[0]["cycle"].toString() + ")",
                                                            style: TextStyle(fontStyle: FontStyle.italic)
                                                        )
                                                    ])
                                            ),
                                        )
                                    ],
                                ),
                            )
                        ],
                    ),
                ),
                Flexible(
                    child: ListView(
                        padding: EdgeInsets.all(5.0),
                        children: <Widget>[
                            createNetsoul(),
                            createFlagList("Fantômes", "ghost", this.widget.profile.ghostLen, Icons.access_alarms),
                            createFlagList("Difficultés", "difficulty", this.widget.profile.difficultyLen, Icons.warning),
                            createFlagList("Encouragements", "remarkable", this.widget.profile.remarkableLen, Icons.thumb_up),
                            createFlagList("Médailles", "medal", this.widget.profile.medalLen, Icons.lightbulb_outline)
                        ],
                    )
                ),
            ],
        );
    }

    Widget createNetsoul() {
        return Container(
            child: Card(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Container(
                                    width: MediaQuery.of(context).size.width / 2 - 20,
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                        title: Text("Semaine dernière"),
                                        subtitle: Text((this.widget.netsoul.weekLog != null) ? this.widget.netsoul.weekLog.toString() + " h" : "NaN"),
                                        leading: Icon(Icons.access_time,
                                            size: 35,
                                            color: Color.fromARGB(255, 41, 155, 203)
                                        ),
                                    ),
                                ),
                                Container(
                                    width: MediaQuery.of(context).size.width / 2 - 20,
                                    child: ListTile(
                                        title: Text("Cette semaine"),
                                        subtitle: Text((this.widget.netsoul.lastWeekLog != null) ? this.widget.netsoul.lastWeekLog.toString() + " h" : "NaN"),
                                        leading: Icon(Icons.group,
                                            size: 35,
                                            color: Color.fromARGB(255, 41, 155, 203)
                                        ),
                                    ),
                                ),
                            ],
                        ),
                        Container(
                            child: Sparkline(
                                data: this.widget.netsoul.time,
                                lineGradient: GradientComponent.green(),
                                fillGradient: GradientComponent.green(),
                                fillMode: FillMode.below,
                                pointsMode: PointsMode.none,
                                pointSize: 7,
                                pointColor: Colors.amber,
                            ),
                        )
                    ],
                ),
            ),
        );
    }

    Widget createFlagList(String listName, String jsonField, int fieldLength, IconData icon) {
        return Container(
            child: Card(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        ListTile(
                            leading: Icon(icon, color: Color.fromARGB(255, 41, 155, 203)),
                            title: Text.rich(
                                TextSpan(
                                    text: listName + "\t-\t",
                                    style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600),
                                    children: <TextSpan>[
                                        TextSpan(
                                            text: fieldLength.toString(),
                                            style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.bold)
                                        )
                                    ]
                                )
                            ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: fieldLength,
                            itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    child: Text(
                                        this.widget.profile.flags[jsonField]["modules"][index]["title"].toString(),
                                        textAlign: TextAlign.center,
                                    )
                                );
                            },
                        )
                    ],
                ),
            ),
        );
    }

}