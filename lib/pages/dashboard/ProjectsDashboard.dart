import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mobile_intranet/pages/dashboard/project/ProjectChild.dart';
import 'package:intl/intl.dart';

class ProjectsDashboard extends StatefulWidget {
    Dashboard dashboard;

    ProjectsDashboard({Key key, @required this.dashboard}) : super(key: key);

    @override
    _ProjectsDashboard createState() => new _ProjectsDashboard();
}

class _ProjectsDashboard extends State<ProjectsDashboard> {

    @override
    Widget build(BuildContext context) {
        // Sort projects
        this.widget.dashboard.projects.sort((a, b) {
            return DateFormat("dd/MM/yyyy").parse(a.endDate).compareTo(DateFormat("dd/MM/yyyy").parse(b.endDate));
        });

        return ListView.builder(
            itemCount: this.widget.dashboard.projects.length,
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
                                                (this.widget.dashboard.projects[index].name.length < 40) ? this.widget.dashboard.projects[index].name : this.widget.dashboard.projects[index].name.substring(0, 35) + " ...",
                                                style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600)
                                            ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 3, top: 2),
                                            child: Text(
                                                (this.widget.dashboard.projects[index].inscriptionDate.toString() == "false") ?
                                                   "  Inscriptions terminées" : "  Inscriptions avant le " + this.widget.dashboard.projects[index].inscriptionDate.toString().split(',')[0],
                                                style: TextStyle(fontFamily: "NunitoSans")
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: LinearPercentIndicator(
                                                width: MediaQuery.of(context).size.width - 100,
                                                lineHeight: 3,
                                                percent: double.parse(this.widget.dashboard.projects[index].timeline) / 100,
                                                progressColor: ((this.widget.dashboard.projects[index].timeline == "100.0000") ? Colors.red : Colors.green),
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
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => ProjectChildPage(project: this.widget.dashboard.projects[index]))
                                                        );
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