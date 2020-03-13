import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mobile_intranet/pages/dashboard/project/ProjectChild.dart';
import 'package:intl/intl.dart';
import 'package:mobile_intranet/parser/components/subcomponents/Project.dart';

class ProjectsDashboard extends StatefulWidget {
    Dashboard dashboard;

    ProjectsDashboard({Key key, @required this.dashboard}) : super(key: key);

    @override
    _ProjectsDashboard createState() => new _ProjectsDashboard();
}

class _ProjectsDashboard extends State<ProjectsDashboard> {

    String checkProjectRegisterState(Project project) {
        if (project.inscriptionDate.toString() == "false" && project.timeline == "0.0000")
            return "Inscriptions non commencées";
        return (project.inscriptionDate.toString() == "false")
            ? "Inscriptions terminées"
            : "Fin des inscriptions le " + project.inscriptionDate.toString().split(',')[0];
    }

    @override
    Widget build(BuildContext context) {
        // Sort projects
        this.widget.dashboard.projects.sort((a, b) {
            return DateFormat("dd/MM/yyyy")
                .parse(a.endDate)
                .compareTo(DateFormat("dd/MM/yyyy").parse(b.endDate));
        });

        return ListView.builder(
            padding: const EdgeInsets.only(top: 20, bottom: 50),
            itemCount: this.widget.dashboard.projects.length,
            itemBuilder: (BuildContext context, int index) {
                Project project = this.widget.dashboard.projects[index];

                return InkWell(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProjectChildPage(project: project))
                        );
                    },
                    child: Container(
                        //margin: const EdgeInsets.only(top: 20, bottom: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                                border: Border.all(
                                    color: Color(0xFFABABAB),
                                    width: 1,
                                )
                            ),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    color: Theme.of(context).cardColor,
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                    Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                            Text(project.name,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w600
                                                                )
                                                            ),

                                                            Text(this.checkProjectRegisterState(project)),
                                                        ],
                                                    ),

                                                    Icon(Icons.arrow_forward_ios,
                                                        color: Colors.black,
                                                        size: 15,
                                                    )
                                                ],
                                            ),

                                            Container(
                                                margin: EdgeInsets.only(top: 10),
                                                child: LinearPercentIndicator(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2),
                                                    width: MediaQuery.of(context).size.width - 55,
                                                    lineHeight: 7,
                                                    percent: double.parse(project.timeline) / 100,
                                                    progressColor: ((project.timeline == "100.0000") ? Colors.red : Colors.green),
                                                )
                                            )
                                        ],
                                    ),
                                )
                            )
                        ),
                    ),
                );
            },
        );
    }
}
