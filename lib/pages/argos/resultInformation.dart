import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/epitest/details/skillDetails.dart';
import 'package:mobile_intranet/parser/components/epitest/result.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultInformationPage extends StatefulWidget
{
    final int id;
    final String bearer;
    final Result result;

    ResultInformationPage({Key key, this.id, this.bearer, this.result}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ResultInformationPageState();

}

class _ResultInformationPageState extends State<ResultInformationPage>
{
    SkillDetails details;

    @override
    void initState()
    {
        super.initState();
	SharedPreferences.getInstance().then((SharedPreferences prefs) {
	    print(this.widget.bearer);
	    Parser(prefs.getString("autolog_url")).parseEpitestDetails(this.widget.id.toString(), this.widget.bearer).then((SkillDetails details) {
		this.setState(() => this.details = details);
		print(this.details.skills.length);
		print(this.details.skills[0].fullSkillReport.tests.length);
	    });
	});
    }

    Color getRadiusColor(double percent) {
	if (percent >= 75)
	    return Colors.green;
	if (percent >= 50)
	    return Colors.orange;
	return Colors.red;
    }

    Widget buildDetails(BuildContext context) {
        if (this.details == null) {
            return Center(child: CircularProgressIndicator());
	}
        return ListView.builder(
	    itemCount: this.details.skills.length,
	    itemBuilder: (BuildContext context, int index) {
		return Column(
		    crossAxisAlignment: CrossAxisAlignment.start,
		    children: <Widget>[
			Container(
			    padding: EdgeInsets.all(5),
			    child: Row(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: <Widget>[
				    Container(
					child: Text(this.details.skills[index].fullSkillReport.name, style: TextStyle(fontWeight: FontWeight.w600),),
				    ),
				    Container(
					margin: EdgeInsets.only(top: 6),
					child: LinearPercentIndicator(
					    percent: this.details.skills[index].fullSkillReport.percent,
					    width: MediaQuery.of(context).size.width / 2 - 100,
					    lineHeight: 4,
					    progressColor: getRadiusColor(this.details.skills[index].fullSkillReport.percent * 100),
					)
				    ),
				],
			    ),
			),
			Container(
			    padding: EdgeInsets.all(5),
			    child: ListView.builder(
				shrinkWrap: true,
				itemCount: this.details.skills[index].fullSkillReport.tests.length,
				physics: const NeverScrollableScrollPhysics(),
				itemBuilder: (BuildContext context, int testIdx) {
				    return Container(
					child: Row(
					    children: <Widget>[
						Text(this.details.skills[index].fullSkillReport.tests[testIdx].name + " > ", style: TextStyle(fontSize: 12),),
						Text(this.details.skills[index].fullSkillReport.tests[testIdx].comment, style: TextStyle(fontSize: 10),),
						Text((this.details.skills[index].fullSkillReport.tests[testIdx].crashed) ? " (Crashed)" : "", style: TextStyle(fontSize: 10),),
					    ],
					),
				    );
				},
			    )
			),
			Divider()
		    ],
		);
	    },
	);
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
	    title: this.widget.result.project.name,
	    child: buildDetails(context),
	    hasProfileButton: false,
	);
    }
}