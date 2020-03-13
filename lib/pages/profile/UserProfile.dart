import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
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
        return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    // Header top profile
                    /*Container(
                      decoration: new BoxDecoration(
                          color: Colors.black,
                          boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(50, 31, 40, 51),
                                  offset: Offset(0, 5),
                                  blurRadius: 20,
                              )
                          ],
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              repeat: ImageRepeat.repeat,
                              image: AssetImage("assets/images/background.png"),
                              colorFilter: ColorFilter.srgbToLinearGamma(),
                          )
                      ),
                      child: Row(
                          children: <Widget>[
                              // Profile image from intranet
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
                  ),*/
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text("Temps de connexion à l'école",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor
                            )
                        ),
                    ),
                    this.createNetsoulLogChart(),
                    this.createFlagsList("Fantômes", "ghost"),
                    this.createFlagsList("Difficultés", "difficulty"),
                    this.createFlagsList("Encouragements", "remarkable"),
                    this.createFlagsList("Médailles", "medal"),
                    SizedBox(height: 20)
                ],
            ),
        );
    }

    /// Create netsoul chart graph
    /// Generate [Sparkline] graph with rounded lines
    Widget createNetsoulLogChart() {
        return Container(
            margin: const EdgeInsets.only(bottom: 15, top: 15),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Color(0xFF464646).withOpacity(0.2),
                            blurRadius: 15.0,
                        )
                    ]
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                        color: Theme.of(context).cardColor,
                        child: Container(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                    Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                        Text("Semaine dernière",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Theme.of(context).primaryColor
                                                            )
                                                        ),
                                                        Text((this.widget.netsoul.weekLog != null) ? this.widget.netsoul.weekLog.toString() + " h" : "NaN",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).primaryColor
                                                            )
                                                        ),
                                                    ],
                                                ),

                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                        Text("Cette semaine",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Theme.of(context).primaryColor
                                                            )
                                                        ),
                                                        Text((this.widget.netsoul.lastWeekLog != null) ? this.widget.netsoul.lastWeekLog.toString() + " h" : "NaN",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                fontWeight: FontWeight.w500,
                                                                color: Theme.of(context).primaryColor
                                                            )
                                                        ),
                                                    ],
                                                )
                                            ],
                                        ),
                                    ),
                                    Container(
                                        child: Sparkline(
                                            data: this.widget.netsoul.time,
                                            lineWidth: 15.0,
                                            lineGradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[
                                                    Color(0xFF0072ff),
                                                    Color(0xFF2F80ED),
                                                ]
                                            ),
                                            fillGradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[
                                                    Color(0xFF0072ff),
                                                    Color(0xFF2F80ED),
                                                ]
                                            ),
                                            fillMode: FillMode.below,
                                            pointsMode: PointsMode.none,
                                        ),
                                    ),
                                    Container(
                                        height: 20,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: <Color>[
                                                    Color(0xFF0072ff),
                                                    Color(0xFF2F80ED),
                                                ]
                                            ),
                                        ),
                                    )
                                ],
                            ),
                        ),
                    ),
                )
            ),
        );
    }

    /// Create the list of flag by title and jsonField
    /// Return a [Widget] with a list of flags
    Widget createFlagsList(String listName, String jsonField) {
        List<dynamic> flagsList = this.widget.profile.flags[jsonField]["modules"];

        // No flags by this type
        if (flagsList.length == 0) {
            return Container();
        }

        return Container(
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Text(listName,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Theme.of(context).primaryColor
                        )
                    ),

                    Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                            children: () {
                                List<Widget> projectsListWidget = [];

                                // Add all activities
                                flagsList.forEach((flag) {
                                    Widget projectWidget = Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                            border: Border.all(
                                                color: Color(0xFFABABAB),
                                                width: 1,
                                            )
                                        ),
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            //color: Theme.of(context).cardColor,
                                            child: Container(
                                                margin: const EdgeInsets.only(left: 5, bottom: 5),
                                                child: Text(flag["title"].toString(),
                                                    style: TextStyle(fontWeight: FontWeight.w600),
                                                ),
                                            ),
                                        )
                                    );

                                    // Add to list
                                    projectsListWidget.add(projectWidget);
                                });

                                return projectsListWidget;
                            }(),
                        ),
                    )
                ],
            ),
        );
    }

}