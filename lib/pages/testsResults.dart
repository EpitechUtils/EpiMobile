import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

/// TODO: (clement) : regarde sur api.epitest.eu y'a tout, si a chaque nouveau test tu peux envoyer une notification push c'est archi cool
/// TestsResults page
/// Get results from my.Epitech.eu
class TestsResultsPage extends StatelessWidget {

    final _webview = new FlutterWebviewPlugin();

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Résultats des tests",
            child: WebviewScaffold(
                url: "https://login.microsoftonline.com/common/oauth2/authorize?client_id=c3728513-e7f6-497b-b319-619aa86f5b50&redirect_uri=https://my.epitest.eu&response_type=id_token",

            ),
        );
        /*
        return DefaultLayout(
            title: "Résultats des tests",
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 8),
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                        SvgPicture.asset("assets/images/icons/under-construction.svg",
                            width: MediaQuery.of(context).size.width / 3,
                        ),

                        SizedBox(height: 50),

                        Text("Patience !",
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 25.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 10),

                        Text("Cette page est encore en développement... "
                            "On sait tous que vous l'attendez avec impatience, mais laissez-nous "
                            "du temps pour vous offrir quelque chose d'encore mieux !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF131313),
                                fontSize: 15.0,
                                fontFamily: "Raleway",
                                letterSpacing: 1.0,
                            )
                        ),

                    ],
                ),
            ),
        );*/
    }
}