import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_intranet/pages/login/webview.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';

class ErrorLogin extends StatelessWidget {

    final IntranetAPIUtils _api = new IntranetAPIUtils();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                        SvgPicture.asset("assets/images/icons/error.svg",
                            width: MediaQuery.of(context).size.width / 2,
                        ),

                        SizedBox(height: 20),

                        Text("Oh non !",
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 15),

                        Text("Nous avons eu un problème lors de la tentative de "
                            "connexion à l'intranet. Peut-être est-il hors-ligne ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 15.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 30),

                        RaisedButton(
                            disabledColor: Colors.redAccent,
                            color: Colors.redAccent,
                            onPressed: () async {
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
                            },
                            autofocus: true,
                            child: Text("Réessayer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                )
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                            )
                        )

                    ],
                ),
            ),
        );
    }

}