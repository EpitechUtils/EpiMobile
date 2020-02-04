import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_intranet/pages/login/webview.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';

/// Login page
/// User can select what acount will be used for requests
class SelectLogin extends StatelessWidget {

    final IntranetAPIUtils _api = new IntranetAPIUtils();
    final String loginEmail;

    /// Constructor
    SelectLogin({@required this.loginEmail});

    /// Create new connection to user
    VoidCallback createNewConnection(BuildContext context) {
        return () {
            // Ask intranet to give authentication URL
            this._api.getAuthURL().then((auth) {
                if (auth == null || auth['office_auth_uri'] == null)
                    return null;

                // Return login URI
                return auth['office_auth_uri'];
            }).then((authURI) {
                // Not logged, need to redirect to SSO page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => LoginWebview(authUrl: authURI)
                ));
            });
        };
    }

    Widget displayAvailableUsers(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

                // Profile image
                Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/icons/user.png")
                        )
                    )
                ),

                SizedBox(height: 10),

                // Login display
                Text(this.loginEmail == null ? "Non connecté" : this.loginEmail,
                    style: TextStyle(
                        fontSize: 16
                    ),
                )
            ],
        );
    }

    /// Render widget
    /// Part of a [StatelessWidget] component
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                        SvgPicture.asset("assets/images/icons/user-select.svg",
                            width: MediaQuery.of(context).size.width / 3,
                        ),

                        SizedBox(height: 20),

                        Text("Selection d'utilisateur",
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 10),

                        Text("Choisissez l'utilisateur sur lequel vous souhaitez "
                            "vous connecter",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 15.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 100),

                        this.displayAvailableUsers(context),

                        SizedBox(height: 30),

                        FlatButton.icon(
                            onPressed: this.createNewConnection(context),
                            color: Color(0xFF131313),
                            icon: Icon(Icons.add,
                                size: 16,
                                color: Colors.white,
                            ),
                            label: Text("Créer nouvelle connexion",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: "Raleway",
                                    letterSpacing: 1.0,
                                )
                            )
                        )

                    ],
                ),
            ),
        );
    }
}