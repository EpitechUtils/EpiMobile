import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/subcomponents/Project.dart';
import 'package:mobile_intranet/parser/components/subcomponents/moduleProject/ModuleProject.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:mobile_intranet/pages/dashboard/project/ProjectChild.dart';

class RegisterContent extends StatefulWidget {
    SharedPreferences prefs;
    ModuleProject moduleProject;
    Project project;

    RegisterContent({ Key key, this.prefs, this.moduleProject, this.project }) : super(key: key);

    @override
    _RegisterContent createState() => new _RegisterContent();
}

class _RegisterContent extends State<RegisterContent> {
    int members;
    List<String> membersMail = new List<String>();

    final memberAddingController = TextEditingController();
    final groupNameController = TextEditingController();

    @override
    void initState() {
        super.initState();

        this.members = 1;
        this.membersMail.add(this.widget.prefs.get("email"));
    }

    @override
    void dispose() {
        super.dispose();

        memberAddingController.dispose();
        groupNameController.dispose();
        this.membersMail.clear();
    }

    @override
    Widget build(BuildContext context) {
        return SimpleDialog(
            contentPadding: EdgeInsets.all(10),
            title: Text("Inscription à " + this.widget.moduleProject.projectTitle),
            children: <Widget>[
                Container(
                    margin: EdgeInsets.all(5),
                    child: TextField(
                        obscureText: false,
                        controller: groupNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nom du groupe (Optionel)"
                        )
                    )
                ),
                buildMemberAddWidget(),
                buildMembersList(),
                Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Container(
                                child: RaisedButton(
                                    child: Text("Valider"),
                                    onPressed: () {
                                        // Make post request
                                        this.setState(() {
                                            List<String> membersClone = []..addAll(this.membersMail);
                                            membersClone.remove(this.widget.prefs.get("email"));

                                            IntranetAPIUtils.internal().registerToProject(
                                                this.widget.prefs.get("autolog_url") + this.widget.project.urlLink + "project/register?format=json",
                                                this.groupNameController.text,
                                                membersClone
                                            ).then((data) {
                                                print(data);
                                                this.members = 1;
                                                this.membersMail.clear();
                                                this.membersMail.add((this.widget.prefs.get("email")));
                                                this.groupNameController.clear();
                                                Navigator.pop(context);

                                                Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (BuildContext context) {
                                                        return ProjectChildPage(project: this.widget.project);
                                                    }
                                                ));
                                            });
                                        });
                                    }
                                )
                            ),
                            Container(
                                child: RaisedButton(
                                    child: Text("Annuler"),
                                    onPressed: () {
                                        this.setState(() {
                                            this.members = 1;
                                            this.membersMail.clear();
                                            this.membersMail.add((this.widget.prefs.get("email")));
                                            this.groupNameController.clear();
                                            Navigator.pop(context);
                                        });
                                    }
                                )
                            )
                        ],
                    )
                ),
            ],
        );
    }

    Widget buildMembersList() {
        if (this.members == 0) {
            return Container(
                child: Text("Aucun membres"),
            );
        }
        return Container(
            height: 100,
            width: 300,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: this.members,
                itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: Row(
                            children: <Widget>[
                                Container(
                                    margin: EdgeInsets.all(5),
                                    width: 40.0,
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(this.widget.prefs.getString("autolog_url")
                                                + "/file/userprofil/" + this.membersMail[index].split('@')[0] + ".bmp"
                                            )
                                        )
                                    )
                                ),
                            ],
                        ),
                    );
                },
            ),
        );
    }

    Widget buildMemberAddWidget() {
        return Container(
            margin: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text("Ajouter des membres"),
                    IconButton(
                        icon: Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 41, 155, 203)
                        ),
                        onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => SimpleDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    children: <Widget>[
                                        TextField(
                                            obscureText: false,
                                            controller: this.memberAddingController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Mail Epitech"
                                            )
                                        ),
                                        SimpleDialogOption(
                                            child: Text("Valider"),
                                            onPressed: () {
                                                // Make post request
                                                this.setState(() {
                                                    if (!this.membersMail.contains(memberAddingController.text)) {
                                                        this.members++;
                                                        this.membersMail.add(memberAddingController.text);
                                                        this.memberAddingController.clear();
                                                        Navigator.pop(context);
                                                    }
                                                });
                                            }
                                        )
                                    ],
                                )
                            );
                        },
                    )
                ],
            ),
        );
    }
}