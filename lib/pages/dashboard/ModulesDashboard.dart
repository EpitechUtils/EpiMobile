import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ModulesDashboard extends StatefulWidget {
    Dashboard dashboard;
    SharedPreferences prefs;

    ModulesDashboard({Key key, @required this.dashboard, @required this.prefs}) : super(key: key);

    @override
    _ModulesDashboard createState() => new _ModulesDashboard();
}

class _ModulesDashboard extends State<ModulesDashboard> {

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: this.widget.dashboard.modules.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(1),
                    child: Card(
                        child: Row(
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
                                                        color: Color.fromARGB(255, 41, 155, 203),
                                                    ),
                                                    onPressed: () {
                                                    }
                                                )
                                            )
                                        ],
                                    )
                                )
                            ],
                        ),
                    )
                );
            },
        );
    }
}