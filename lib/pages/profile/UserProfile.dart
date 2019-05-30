import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// UserProfile state ful creator
/// Create state and interact with him
class UserProfile extends StatefulWidget {

    /// Constructor
    UserProfile({Key key}) : super(key: key);

    /// Creating state
    _UserProfile createState() => _UserProfile();

}

class _UserProfile extends State<UserProfile> {

    SharedPreferences _prefs;

    @override
    Widget build(BuildContext context) {
        // Load shared preferences
        SharedPreferences.getInstance()
            .then((SharedPreferences prefs) => this.setState(() => _prefs = prefs));

        // Is content is loading, display progress loader
        if (this._prefs == null) {
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                    child: CircularProgressIndicator(),
                ),
            );
        }

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
                            ),
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
                                                fit: BoxFit.fill,
                                                image: NetworkImage(_prefs.getString("autolog_url") + "/file/userprofil/profilview/cyril.colinet.jpg")
                                            )
                                        )
                                    ),
                                ),
                            )
                        ],
                    ),
                )
            ],
        );
    }

}