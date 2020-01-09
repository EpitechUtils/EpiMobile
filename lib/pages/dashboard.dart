import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/dashboard/categoryButtonsList.dart';
import 'package:mobile_intranet/components/layouts/default.dart';

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

    /// Init the new state
    @override
    void initState() {
        super.initState();

        // Create componebts
        this._components.add(new Text("mdr", style: TextStyle(color: Colors.white)));
        this._components.add(new Container());
        this._components.add(new Container());
        this._components.add(new Container());

        //
    }

    /// Build widget
    /// Adding controller to manager scrolling
    @override
    Widget build(BuildContext context) {
        return DefaultLayout(body: this.displayContent());
    }

    /// Change current page and rebuild current widget
    void changeCurrentPage(int page) {
        this.setState(() {
            this._currentPage = page;
        });
    }

    /// Default content management
    Widget displayContent() {
        // Content loaded and images available
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 2),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("Tableau de Bord",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontFamily: "CalibreSemibold",
                                        letterSpacing: 1.0,
                                    )
                                ),

                                // Tricolor fire
                            ],
                        ),
                    ),

                    // Content here
                    CategoryButtonsList(
                        page: this._currentPage,
                        changePageCallback: this.changeCurrentPage
                    ),

                    // Display content
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: this._components[this._currentPage],
                    )
                ],
            ),
        );
    }

}

