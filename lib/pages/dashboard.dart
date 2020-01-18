import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/customLoader.dart';
import 'package:mobile_intranet/components/dashboard/categoryButtonsList.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/pages/dashboard/reminders.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dashboard Stateful [Widget]
/// Implements the feed of viral images
class Dashboard extends StatefulWidget {
    @override
    _DashboardState createState() => new _DashboardState();
}

/// Dashboard State of the [Dashboard] Stateful Widget
class _DashboardState extends State<Dashboard> {

    int _currentPage = 0;
    List<Widget> _components = [];
    Parser _parser;

    /// Init the new state
    @override
    void initState() {
        super.initState();

        // Get autologin url and parse dashboard content
        SharedPreferences.getInstance().then((SharedPreferences prefs) {
            // Set parser in state and reload page
            this.setState(() {
                this._parser = Parser(prefs.getString("autolog_url"));

                // Create componebts
                this._components.add(new ReminderDashboard(parser: this._parser));
                this._components.add(new Container());
                this._components.add(new Container());
                this._components.add(new Container());
            });
        });
    }

    /// Change current page and rebuild current widget
    void changeCurrentPage(int page) {
        this.setState(() {
            this._currentPage = page;
        });
    }

    /// Build widget
    /// Adding controller to manager scrolling
    @override
    Widget build(BuildContext context) {
        return DefaultLayout(body: this.displayContent());
    }

    /// Default content management
    Widget displayContent() {
        // Content loaded and images available
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("Tableau de Bord",
                                    style: Theme.of(context).textTheme.title
                                ),

                                // Tricolor fire
                                Container()
                            ],
                        ),
                    ),

                    Container(
                        width: MediaQuery.of(context).size.width - 40,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                offset: Offset(3.0, 6.0),
                                                blurRadius: 10.0
                                            )
                                        ]
                                    ),
                                    child: Column(
                                        children: <Widget>[

                                            Padding(
                                                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                                                child: Row(
                                                    children: <Widget>[

                                                        SizedBox(
                                                            width: 50,
                                                            child: Icon(Icons.refresh,
                                                                size: 30,
                                                                color: Theme.of(context).primaryIconTheme.color,
                                                            ),
                                                        ),

                                                        Flexible(
                                                            child: Text("Connectez-vous à votre compte Google Calendar afin de"
                                                                "pouvoir synchroniser vos activités à votre calendrier.",
                                                                overflow: TextOverflow.clip,
                                                                style: TextStyle(
                                                                    color: Color(0xFF131313),
                                                                    fontSize: 15,
                                                                    fontFamily: "Raleway",
                                                                    letterSpacing: 1.0,
                                                                )
                                                            ),
                                                        )

                                                    ],
                                                ),
                                            ),

                                            InkWell(
                                                onTap: () {},
                                                child: Container(
                                                    color: Theme.of(context).buttonColor,
                                                    height: 35,
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Align(
                                                        alignment: Alignment.center,
                                                        child: Text("Connexion à Google",
                                                            style: Theme.of(context).textTheme.button,
                                                        ),
                                                    )
                                                ),
                                            )
                                        ],
                                    )
                                ),
                            ),
                        ),
                    ),

                    // Content here
                    /*CategoryButtonsList(
                        page: this._currentPage,
                        changePageCallback: this.changeCurrentPage
                    ),*/

                    // Display content
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: (this._parser == null) ?
                            CustomLoader() :
                            this._components[this._currentPage],
                    )
                ],
            ),
        );
    }

}

