import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:mobile_intranet/parser/components/subcomponents/Project.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProject.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectsDashboard extends StatelessWidget {
    final Dashboard dashboard;

    /// AbsenceProfile Ctor
    ProjectsDashboard({Key key, @required this.dashboard}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: this.dashboard.projects.length,
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
                                                this.dashboard.projects[index].name,
                                                style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600)
                                            ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 3, top: 2),
                                            child: Text(
                                                (this.dashboard.projects[index].inscriptionDate.toString() == "false") ?
                                                   "  Inscriptions terminées" : "  Inscriptions avant le " + this.dashboard.projects[index].inscriptionDate.toString().split(',')[0],
                                                style: TextStyle(fontFamily: "NunitoSans")
                                            )
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(top: 2),
                                            child: LinearPercentIndicator(
                                                width: MediaQuery.of(context).size.width - 100,
                                                lineHeight: 3,
                                                percent: double.parse(this.dashboard.projects[index].timeline) / 100,
                                                progressColor: (this.dashboard.projects[index].timeline == "100.0000") ? Colors.red : Colors.green,
                                            )
                                        )
                                    ],
                                ),
                                Container(
                                    child: IconButton(
                                        icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color.fromARGB(255, 41, 155, 203),
                                        ),
                                        onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => ProjectChildPage(project: this.dashboard.projects[index]))
                                            );
                                        }
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

class ProjectChildPage extends StatefulWidget {
    final Project project;

    ProjectChildPage({Key key, @required this.project}) : super(key: key);

    @override
    _ProjectChildPage createState() => new _ProjectChildPage();
}

class _ProjectChildPage extends State<ProjectChildPage> {
    ModuleProject _moduleProject;
    SharedPreferences _prefs;

    @override
    void initState() {
        super.initState();
    }

    _ProjectChildPage() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() {
            this._prefs = prefs;
            Parser parser = Parser(prefs.getString("autolog_url"));

            parser.parseModuleProject(prefs.get("email"), this.widget.project.urlLink)
                .then((ModuleProject moduleProject) => this.setState(() {
                this._moduleProject = moduleProject;
            }));
        }));
    }

    @override
    Widget build(BuildContext context) {
        if (this._moduleProject == null) {
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                        "Loading...",
                        style: TextStyle(fontFamily: "NunitoSans")
                    ),
                ),
                body: Center(
                    child: Text(
                        "Loading...",
                        style: TextStyle(fontFamily: "NunitoSans")
                    ),
                )
            );
        } else {
            return Scaffold(
                appBar: AppBar(
                    title: Text(
                        this._moduleProject.projectTitle,
                        style: TextStyle(fontFamily: "NunitoSans")
                    ),
                ),
                body: Column(
                    children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                boxShadow: [
                                    BoxShadow(
                                        color: Color.fromARGB(50, 31, 40, 51),
                                        offset: Offset(-5, 0),
                                        blurRadius: 20,
                                    )
                                ],
                                image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    repeat: ImageRepeat.repeat,
                                    image: AssetImage("assets/images/background.png")
                                )
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            children: <Widget>[
                                                Icon(Icons.people, color: Color.fromARGB(255, 41, 155, 203)),
                                                Text(
                                                    (this._moduleProject.groupMax == 1) ? "Projet solo" : this._moduleProject.groupMin.toString() + " à " + this._moduleProject.groupMax.toString(),
                                                    style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600),
                                                )
                                            ],
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: CircularPercentIndicator(
                                            radius: 60,
                                            lineWidth: 2,
                                            percent: double.parse(this.widget.project.timeline) / 100,
                                            progressColor: (this.widget.project.timeline == "100.0000") ? Colors.red : Colors.green,
                                            center: Text(double.parse(this.widget.project.timeline).toStringAsFixed(1) + "%", style: TextStyle(fontWeight: FontWeight.w600),),
                                        )
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text.rich(
                                            TextSpan(
                                                text: (DateTime.parse(this._moduleProject.end.split(',')[0]).isBefore(DateTime.now())) ? "Projet terminé" : "J ",
                                                style: TextStyle(fontFamily: "NunitoSans"),
                                                children: <TextSpan>[
                                                    TextSpan(
                                                        text: (DateTime.parse(this._moduleProject.end.split(',')[0]).isBefore(DateTime.now())) ? "" :
                                                        (DateTime.now().difference(DateTime.parse(this._moduleProject.end.split(',')[0]))).inDays.toString(),
                                                        style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600)
                                                    )
                                                ]
                                            )
                                        ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                            children: <Widget>[
                                                Icon(
                                                    (this._moduleProject.userProjectStatus == "project_confirmed") ? Icons.check_circle : Icons.error,
                                                    color: Color.fromARGB(255, 41, 155, 203)
                                                ),
                                                Text(
                                                    (this._moduleProject.userProjectStatus == "project_confirmed") ? "Inscrit" : "Non inscrit",
                                                    style: TextStyle(fontFamily: "NunitoSans")
                                                )
                                            ],
                                        ),
                                    )
                                ],
                            ),
                        ),
                        Flexible(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: this._moduleProject.groups.length,
                                itemBuilder: (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                            children: <Widget>[
                                                Card(
                                                    child: Row(
                                                        children: <Widget>[
                                                            Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: <Widget>[
                                                                    Padding(
                                                                        padding: EdgeInsets.all(8.0),
                                                                        child: Text(
                                                                            this._moduleProject.groups[index].groupName,
                                                                            style: TextStyle(fontFamily: "NunitoSans", fontWeight: FontWeight.w600),
                                                                        )
                                                                    ),
                                                                    Row(
                                                                        children: <Widget>[
                                                                            Container(
                                                                                margin: EdgeInsets.all(5),
                                                                                width: 50.0,
                                                                                height: 50.0,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.circle,
                                                                                    image: DecorationImage(
                                                                                        fit: BoxFit.cover,
                                                                                        image: NetworkImage(this._prefs.getString("autolog_url")
                                                                                            + this._moduleProject.groups[index].master.picture
                                                                                        )
                                                                                    )
                                                                                )
                                                                            ),
                                                                            Container(
                                                                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                                                                height: 40.0,
                                                                                child: ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemBuilder: (context, memberIndex) {
                                                                                        return Container(
                                                                                            margin: EdgeInsets.all(5),
                                                                                            width: 30.0,
                                                                                            decoration: BoxDecoration(
                                                                                                shape: BoxShape.circle,
                                                                                                image: DecorationImage(
                                                                                                    fit: BoxFit.cover,
                                                                                                    image: NetworkImage(this._prefs.getString("autolog_url")
                                                                                                        + this._moduleProject.groups[index].members[memberIndex].picture
                                                                                                    )
                                                                                                )
                                                                                            )
                                                                                        );
                                                                                    },
                                                                                    itemCount: this._moduleProject.groups[index].members.length, // this is a hardcoded value
                                                                                ),
                                                                            )
                                                                        ],
                                                                    )
                                                                ],
                                                            )
                                                        ],
                                                    ),
                                                ),
                                            ],
                                        ),
                                    );
                                }
                            ),
                        )
                    ],
                )
            );
        }
    }
}