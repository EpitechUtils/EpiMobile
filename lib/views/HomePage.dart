import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mobile_intranet/components/NetsoulChart.dart';
import 'package:mobile_intranet/components/ui/widgets/login_background.dart';
import 'package:mobile_intranet/components/ui/widgets/profile_tile.dart';
import 'package:mobile_intranet/components/utils/uidata.dart';
import 'package:mobile_intranet/views/DashboardPage.dart';
import 'package:mobile_intranet/views/LoginPage.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    Size _deviceSizes;


    Widget displayAppBar(BuildContext _scaffoldContext) {
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
                                    onPressed: () => Scaffold.of(_scaffoldContext).openDrawer(),
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
                            ),

                            Container(
                                margin: const EdgeInsets.only(top: 20.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                        Text("Mon chibron",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold
                                            ),
                                        )
                                    ],
                                )
                            )

                        ],
                    )
                ),
            ),
        );
    }

    Widget displayDevelopmentMode() {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                color: Colors.orangeAccent,
                elevation: 2.0,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            margin: const EdgeInsets.only(right: 5.0),
                                            child: Icon(
                                                Icons.warning,
                                                size: 13.0,
                                                color: Colors.white
                                            )
                                        ),

                                        Text("Application encore en développement !",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                            )
                                        ),
                                    ],
                                ),
                            ),

                            Text("N'hésitez pas à nous remonter chaque problème(s) que vous trouvez, "
                                "même visuel, le but étant justement d'avoir quelque chose de parfait.",
                                style: TextStyle(
                                    color: Colors.white
                                )
                            )
                        ],
                    )
                ),
            ),
        );
    }

    Widget displayCards(BuildContext _scaffoldContext) {
        return SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    // Application bar
                    this.displayAppBar(_scaffoldContext),
                    // Divider
                    SizedBox(height: this._deviceSizes.height * 0.01),
                    // App curently in dev mode
                    this.displayDevelopmentMode(),
                    // Divider
                    SizedBox(height: this._deviceSizes.height * 0.01),
                    // Netsoul log chart
                    this.displayLogtimeChart(),
                    // Divider
                    SizedBox(height: this._deviceSizes.height * 0.01)
                ],
            )
        );
    }

    List<Widget> userConstantsInformations() {
        return <Widget>[

            /// Credits
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text("60", style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text("Crédits", style: TextStyle(color: Colors.white)),
                ],
            ),

            /// GPA
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text("3.56", style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text("GPA", style: TextStyle(color: Colors.white)),
                ],
            ),

            // Spices
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text("20", style: TextStyle(fontSize: 20, color: Colors.white)),
                    Text("Épices", style: TextStyle(color: Colors.white)),
                ],
            )

        ];
    }

    @override
    Widget build(BuildContext context) {
        this._deviceSizes = MediaQuery.of(context).size;

        return Scaffold(
            drawer: new Drawer(
                child: ListView(
                    padding: const EdgeInsets.all(0.0),
                    children: <Widget>[
                        // user drawer
                        new UserAccountsDrawerHeader(
                            accountName: Row(
                                children: <Widget>[

                                    // Fire
                                    Container(
                                        width: 10.0,
                                        height: 10.0,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.orange
                                        ),
                                    ),

                                    // Account name
                                    Text('Cyril Colinet',
                                        style: TextStyle(fontSize: 20)
                                    )
                                ],
                            ),
                            accountEmail: new Text('cyril.colinet@epitech.eu'),
                            currentAccountPicture: new CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: new NetworkImage('https://avatars2.githubusercontent.com/u/8271271?s=400&u=aa8e1179b37cb3d76dc9d35b939862a3b40aa9e4&v=4')
                            ),
                            otherAccountsPictures: this.userConstantsInformations(),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                    colorFilter:
                                    new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                                    image: AssetImage("assets/images/drawer-header.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                        ),
                        new ListTile(
                            title: new Text('About Page'),
                            onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) => new LoginPage()));
                            },
                        ),
                    ],
                ),
            ),
            body: Builder(
                builder: (BuildContext _scaffoldContext) {
                    return Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                            // Background
                            LoginBackground(showIcon: false),
                            // Other cards
                            this.displayCards(_scaffoldContext)
                        ],
                    );
                }
            )
        );
    }

}
