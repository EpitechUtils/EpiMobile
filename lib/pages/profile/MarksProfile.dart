import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';
import 'package:mobile_intranet/parser/components/profile/ProfileMark.dart';

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
        print(parsedMarks);

        var scolarYearKeys = parsedMarks.keys.toList();

	return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
                //return Text(this.profile.marks[index].name + " :  "  + ((this.profile.marks[index].mark == null) ? "?" : this.profile.marks[index].mark.toStringAsFixed(this.profile.marks[index].mark.truncateToDouble() == this.profile.marks[index].mark ? 0 : 1))
                //+ " : " + this.profile.marks[index].scolarYear.toString() + " : " + this.profile.marks[index].codeModule);
                return ExpansionTile(
                    title: Text(scolarYearKeys[index]),
                    //children: parsedMarks["2017"][modulesKeys[index]].toList()
                    children: buildListModules(parsedMarks[scolarYearKeys[index]]),
                );
            },
            //itemCount: this.profile.marks.length,
            itemCount: scolarYearKeys.length,
        );
    }

    List<Widget> buildListModules(Map<String, List<ProfileMark>> modules)
    {
        List<Widget> widgets = new List<Widget>();
        var keys = modules.keys;

        for (var elem in keys) {
            widgets.add(ExpansionTile(
                title: Text(elem),
                children: buildListMark(modules[elem])
            ));
        }
        return widgets;
    }

    List<Widget> buildListMark(List<ProfileMark> mark)
    {
        List<Widget> widgets = new List<Widget>();

        for (var elem in mark) {
            widgets.add(Container(
                child: Text(elem.codeModule + " : " + elem.name + "    " + elem.mark.toString())
            ));
        }
        return widgets;
    }
}