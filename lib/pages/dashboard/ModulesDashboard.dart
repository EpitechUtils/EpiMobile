import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_intranet/pages/dashboard/module/ModuleDetails.dart';

class ModulesDashboard extends StatefulWidget {
    final Dashboard dashboard;

    ModulesDashboard({Key key, @required this.dashboard}) : super(key: key);

    @override
    _ModulesDashboard createState() => new _ModulesDashboard();
}

class _ModulesDashboard extends State<ModulesDashboard> {

    @override
    Widget build(BuildContext context) {
        if (this.widget.dashboard.modules.length == 0) {
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        SvgPicture.asset("assets/images/icons/shelf.svg",
                            width: MediaQuery.of(context).size.width / 3,
                        ),

                        SizedBox(height: 20),

                        Text("Pas de données trouvées...",
                            style: TextStyle(
                                //color: Color(0xFF131313),
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold
                                //fontFamily: "Raleway",
                                //letterSpacing: 1.0,
                            )
                        ),

                        SizedBox(height: 50),
                    ],
                ),
            );
        }

        return ListView.builder(
            itemCount: this.widget.dashboard.modules.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(1),
                    child: Column(
                        children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.only(left: 10),
                                                child: Text(
                                                    this.widget.dashboard.modules[index].name,
                                                    style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600)
                                                ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(left: 3, top: 2),
                                                child: Text(
                                                    (this.widget.dashboard.modules[index].inscriptionDate.toString() == "false") ?
                                                    "  Inscriptions terminées" : "  Inscriptions avant le " + this.widget.dashboard.modules[index].inscriptionDate.toString().split(',')[0],
                                                    style: TextStyle(fontFamily: "NunitoSans")
                                                )
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(top: 2),
                                                child: LinearPercentIndicator(
                                                    width: MediaQuery.of(context).size.width - 100,
                                                    lineHeight: 3,
                                                    percent: double.parse(this.widget.dashboard.modules[index].timelineBarre) / 100,
                                                    progressColor: ((this.widget.dashboard.modules[index].timelineBarre == "100.0000") ? Colors.red : Colors.green),
                                                )
                                            )
                                        ],
                                    ),
                                    Container(
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Container(
                                                    child: IconButton(
                                                        icon: Icon(
                                                            Icons.arrow_forward_ios,
                                                            color: Color(0xFF131313),
                                                        ),
                                                        onPressed: () {
                                                            Navigator.push(context, MaterialPageRoute(
                                                                builder: (context) => ModuleDetails()
                                                            ));
                                                        }
                                                    )
                                                )
                                            ],
                                        )
                                    )
                                ],
                            ),
                            Divider()
                        ],
                    )
                );
            },
        );
    }
}