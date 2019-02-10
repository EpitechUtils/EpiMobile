import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_intranet/components/NetsoulChart.dart';
import 'package:mobile_intranet/components/ui/widgets/login_background.dart';
import 'package:mobile_intranet/components/ui/widgets/profile_tile.dart';
import 'package:mobile_intranet/components/utils/uidata.dart';
import 'package:mobile_intranet/views/DashboardPage.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _selectedIndex = 0;
    List<Widget> _pages;
    Size _deviceSizes;

    @override
    void initState() {
        // Init differents inside home view
        this._pages = <Widget>[
            DashboardPage(),
            DashboardPage(),
            DashboardPage(),
            DashboardPage(),
        ];

        super.initState();
    }

    Widget displayAppBar() {
        return SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 18.0),
                child: new Column(
                    children: <Widget>[
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                new IconButton(
                                    icon: new Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                    ),
                                    onPressed: () => Navigator.canPop(context)
                                        ? Navigator.pop(context)
                                        : null,
                                ),
                                new ProfileTile(
                                    title: "Bonjour, Cyril",
                                    subtitle: "Bienvenue sur l'intranet Epitech",
                                    textColor: Colors.white,
                                ),
                                new IconButton(
                                    icon: new Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                    ),
                                    onPressed: () {
                                        print("hi");
                                    },
                                )
                            ],
                        ),
                    ],
                ),
            ),
        );
    }

    Widget displayLogtimeChart() {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 2.0,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children: <Widget>[

                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                    Text("Temps de connexion",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                    )
                                ],
                            ),

                            Container(
                                height: 200.0,
                                child: NetsoulChart.withSampleData(),
                            )

                        ],
                    )
                ),
            ),
        );
    }

    Widget displayCards() {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[

                    // Application bar
                    this.displayAppBar(),

                    // Divider
                    SizedBox(height: this._deviceSizes.height * 0.01),

                    // Netsoul log chart
                    this.displayLogtimeChart(),

                ],
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        this._deviceSizes = MediaQuery.of(context).size;

        return Scaffold(
            body: Stack(
                fit: StackFit.expand,
                children: <Widget>[

                    // Background
                    LoginBackground(showIcon: false),

                    // Other cards
                    this.displayCards()

                ],
            )
        );
    }

}
