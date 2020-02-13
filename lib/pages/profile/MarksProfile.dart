import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:mobile_intranet/parser/components/profile/ProfileMark.dart';
import 'package:mobile_intranet/parser/components/profile/ProfileModules.dart';

class MarksProfile extends StatelessWidget {
    final Profile profile;
    Map<String, Map<String, List<ProfileMark>>> parsedMarks = new Map<String, Map<String, List<ProfileMark>>>();

    MarksProfile({Key key, @required this.profile}) : super(key: key);

    void initState()
    {
        // Fill parsedMarks with scolar years
        for (var elem in profile.marks) {
            if (!parsedMarks.containsKey(elem.scolarYear)) {
                parsedMarks[elem.scolarYear.toString()] = new Map<String, List<ProfileMark>>();
            }
        }
        print(parsedMarks);
    }

    @override
    Widget build(BuildContext context) {

        // Fill parsedMarks with scolar years
        for (var elem in profile.marks) {
            if (!parsedMarks.containsKey(elem.scolarYear)) {
                parsedMarks[elem.scolarYear.toString()] = Map<String, List<ProfileMark>>();
            }
        }

        // Fill parsedMarks with code-acti
        for (var elem in profile.marks) {
            if (!parsedMarks[elem.scolarYear.toString()].containsKey(elem.codeModule)) {
                parsedMarks[elem.scolarYear.toString()][elem.codeModule] = List<ProfileMark>();
            }
        }

        // Fill parsedMarks marks
        for (var elem in profile.marks) {
            parsedMarks[elem.scolarYear.toString()][elem.codeModule].add(elem);
        }

        var scolarYearKeys = parsedMarks.keys.toList();

	return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
                //return Text(this.profile.marks[index].name + " :  "  + ((this.profile.marks[index].mark == null) ? "?" : this.profile.marks[index].mark.toStringAsFixed(this.profile.marks[index].mark.truncateToDouble() == this.profile.marks[index].mark ? 0 : 1))
                //+ " : " + this.profile.marks[index].scolarYear.toString() + " : " + this.profile.marks[index].codeModule);
                return ExpansionTile(
                    title: Text(scolarYearKeys[index]),
                    //children: parsedMarks["2017"][modulesKeys[index]].toList()
                    children: buildListModules(context, parsedMarks[scolarYearKeys[index]]),
                );
            },
            //itemCount: this.profile.marks.length,
            itemCount: scolarYearKeys.length,
        );
    }

    List<Widget> buildListModules(BuildContext context, Map<String, List<ProfileMark>> modules)
    {
        List<Widget> widgets = new List<Widget>();
        var keys = modules.keys;
        ProfileModules m;

        for (var elem in keys) {
	    for (var elemModule in this.profile.modules) {
		if (elemModule.codeModule == modules[elem][0].codeModule && elemModule.scolarYear == modules[elem][0].scolarYear) {
		    m = elemModule;
		    break;
		}
	    }
            widgets.add(ExpansionTile(
                title: Container(
		    child: Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
			    Text(elem),
			    Text.rich(
				TextSpan(
                                    children: <TextSpan>[
                                        TextSpan(
                                            text: m.grade,
                                            style: TextStyle(fontWeight: FontWeight.w600)
                                        ),
                                        TextSpan(
                                            text: " - " + m.credits.toString() + " crédits",
                                            style: TextStyle(fontSize: 12)
                                        ),
                                    ]
                                )
			    ),
			],
		    ),
		),
                children: buildListMark(context, modules[elem])
            ));
        }
        return widgets;
    }

    List<Widget> buildListMark(BuildContext context, List<ProfileMark> mark)
    {
        List<Widget> widgets = new List<Widget>();

        for (var elem in mark) {
            widgets.add(Container(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6, right: MediaQuery.of(context).size.width / 6),
                child: Column(
                    children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text((elem.name.length > 25) ? elem.name.substring(0, 25) + "..." : elem.name),
                                Text(elem.mark.toString())
                            ],
                        ),
                        Divider()
                    ],
                ),
            ));
        }

        // Compute total
        double total = 0;
        double marksAmount = 0;

        for (var elem in mark) {
            if (!elem.name.toLowerCase().contains("review")) {
                total += elem.mark;
                marksAmount++;
            }
        }
        total /= marksAmount;

        widgets.add(Container(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6, right: MediaQuery.of(context).size.width / 6, bottom: 10),
            child: Column(
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("Moyenne", style: TextStyle(fontWeight: FontWeight.w800),),
                            Text(total.toStringAsPrecision(4), style: TextStyle(fontWeight: FontWeight.w600),),
                        ],
                    ),
                ],
            ),
        ));

        return widgets;
    }
}