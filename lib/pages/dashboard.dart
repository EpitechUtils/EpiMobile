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
            child: Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20, bottom: 2),
                child: Column(
                    children: <Widget>[
                        Row(
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

                        // Content here
                        CategoryButtonsList(page: this._currentPage)
                    ],
                ),
            )
        );
    }

}

