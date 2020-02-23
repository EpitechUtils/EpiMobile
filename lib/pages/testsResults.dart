import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/epitest/result.dart';
import 'package:mobile_intranet/parser/components/epitest/results.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/argos/resultInformation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestsResultsPage extends StatefulWidget {

    TestsResultsPage({Key key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _TestsResultsPageState();
}

class _TestsResultsPageState extends State<TestsResultsPage> {

    final _webview = new FlutterWebviewPlugin();
    StreamSubscription<WebViewStateChanged> _onStateChanged;
    String token;
    Results results;
    SharedPreferences prefs;
    bool resetLocalStorage = false;
    String date;

    _TestsResultsPageState() {
	this.date = (DateTime.now().year - 1).toString();
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() => this.prefs = prefs));
    }

    @override
    void dispose() {
        _onStateChanged.cancel();
        _webview.dispose();
        super.dispose();
    }

    @override
    void initState() {
        super.initState();
        _onStateChanged = _webview.onStateChanged.listen(this.onStateChanged);
    }

    void onStateChanged(WebViewStateChanged state) async {
        if (state.url.startsWith("https://my.epitech.eu/index.html")) {
            if (state.type == WebViewState.shouldStart)
                this._webview.hide();

            if (mounted && state.type == WebViewState.finishLoad) {
                _webview.evalJavascript('localStorage.getItem("argos-elm-openidtoken")').then((value) {
                    print(value);
                    if (value != null && value != "null") {
                        this._webview.close();
                        this.setState(() => this.token = value.replaceAll('"', ''));
                        this.parseResults(this.date);
                    }
                });
            }
        }
    }

    void parseResults(String year) {
        Parser(this.prefs.getString("autolog_url")).parseEpitest(year, this.token).then((Results res) {
           this.setState(() => this.results = res);
        });
    }

    Color getRadiusColor(double percent) {
        if (percent >= 75)
            return Colors.green;
        if (percent >= 50)
            return Colors.orange;
        return Colors.red;
    }

    Widget buildResultScore(BuildContext context, Result result) {
        return Container(
            child: Stack(
                children: <Widget>[
                    Positioned(
                        child: Text(result.results.percentage.toStringAsPrecision(3), style: TextStyle(fontWeight: FontWeight.w700),),
                        left: 17,
                        top: 25,
                    ),
                    CircularPercentIndicator(
                        radius: 60,
                        percent: result.results.percentage / 100,
                        progressColor: getRadiusColor(result.results.percentage),
                        backgroundColor: Colors.black45,
                    )
                ],
            ),
        );
    }

    Widget buildMetrics(BuildContext context, Result result) {
        return Container(
            child: Column(
                children: <Widget>[
                    Container(
			width: 60,
			child: Row(
			    mainAxisAlignment: MainAxisAlignment.spaceBetween,
			    children: <Widget>[
			        Text("Major", style: TextStyle(fontWeight: FontWeight.w400),),
				Text(result.results.externalItems.firstWhere((elem) {
				    return elem.type == "lint.major";
				}).value.toStringAsPrecision(1))
			    ],
			),
		    ),
		    Container(
			width: 60,
			child: Row(
			    mainAxisAlignment: MainAxisAlignment.spaceBetween,
			    children: <Widget>[
				Text("Minor", style: TextStyle(fontWeight: FontWeight.w400),),
				Text(result.results.externalItems.firstWhere((elem) {
				    return elem.type == "lint.minor";
				}).value.toStringAsPrecision(1))
			    ],
			),
		    ),
		    Container(
			width: 60,
			child: Row(
			    mainAxisAlignment: MainAxisAlignment.spaceBetween,
			    children: <Widget>[
				Text("Info", style: TextStyle(fontWeight: FontWeight.w400),),
				Text(result.results.externalItems.firstWhere((elem) {
				    return elem.type == "lint.info";
				}).value.toStringAsPrecision(1))
			    ],
			),
		    ),
                ],
            ),
        );
    }

    Widget buildCoverage(BuildContext context, Result result) {
        return Container(
            child: Row(
                children: <Widget>[
                    Container(
                        child: Stack(
                            children: <Widget>[
                                Positioned(
                                    child: Text(
                                        result.results.externalItems.firstWhere((elem) => elem.type == "coverage.branches", orElse: () => null)?.value?.toStringAsPrecision(3) ?? "0.00"
                                    ),
                                    left: 17,
                                    top: 25,
                                ),
                                CircularPercentIndicator(
                                    radius: 60,
                                    percent: (result.results.externalItems.firstWhere((elem) => elem.type == "coverage.branches", orElse: () => null)?.value ?? 0) / 100,
                                    progressColor: getRadiusColor(result.results.externalItems.firstWhere((elem) => elem.type == "coverage.branches", orElse: () => null)?.value ?? 0),
                                    backgroundColor: Colors.black45,
                                )
                            ],
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Stack(
                            children: <Widget>[
                                Positioned(
                                    child: Text(
                                        result.results.externalItems.firstWhere((elem) => elem.type == "coverage.lines", orElse: () => null)?.value?.toStringAsPrecision(3) ?? "0.00"
                                    ),
                                    left: 17,
                                    top: 25,
                                ),
                                CircularPercentIndicator(
                                    radius: 60,
                                    percent: (result.results.externalItems.firstWhere((elem) => elem.type == "coverage.lines", orElse: () => null)?.value ?? 0) / 100,
                                    progressColor: getRadiusColor(result.results.externalItems.firstWhere((elem) => elem.type == "coverage.lines", orElse: () => null)?.value ?? 0),
                                    backgroundColor: Colors.black45,
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    Widget buildYearSelector(BuildContext context) {
        return Container(
	    margin: EdgeInsets.only(left: 10),
	    child: Row(
		children: <Widget>[
		    Text("Année: "),
		    DropdownButton<String>(
			value: this.date,
			items: <String>[(DateTime.now().year - 1).toString(), (DateTime.now().year - 2).toString(), (DateTime.now().year - 3).toString(), (DateTime.now().year - 4).toString(), (DateTime.now().year - 5).toString()]
			    .map<DropdownMenuItem<String>>((String value) {
			    return DropdownMenuItem<String>(
				value: value,
				child: Text(value),
			    );
			}).toList(),
			onChanged: (String value) {
			    this.setState(() {
				this.date = value;
				this.results = null;
				this.parseResults(this.date);
			    });
			},
		    ),
		],
	    )
	);
    }

    Widget buildTestsResults(BuildContext context) {
        return Flexible(
	    child: ListView.builder(
		itemCount: this.results.results.length,
		itemBuilder: (BuildContext context, int index) {
		    return InkWell(
			onTap: () {
			    Navigator.of(context).push(MaterialPageRoute(
				builder: (context) => ResultInformationPage(
				    bearer: this.token,
				    result: this.results.results[index],
				    id: this.results.results[index].results.testRunId,
				)
			    ));
			},
			child: Column(
			    children: <Widget>[
				Container(
				    padding: EdgeInsets.all(5),
				    child: Row(
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
					    Text(this.results.results[index].project.module.code + " - ", style: TextStyle(fontWeight: FontWeight.w600),),
					    Text(this.results.results[index].project.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
					],
				    )
				),
				Container(
				    child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceAround,
					children: <Widget>[
					    buildResultScore(context, this.results.results[index]),
					    buildMetrics(context, this.results.results[index]),
					    buildCoverage(context, this.results.results[index])
					],
				    ),
				),
				Divider()
			    ],
			)
		    );
		}
	    )
	);
    }

    Widget buildResults(BuildContext context) {
        return Column(
	    crossAxisAlignment: CrossAxisAlignment.start,
	    children: <Widget>[
	        buildYearSelector(context),
		Divider(),
		buildTestsResults(context)
	    ],
	);
    }

    @override
    Widget build(BuildContext context) {

        if (this.token == null)
            return DefaultLayout(
                title: "Résultat des tests",
                child: WebviewScaffold(
                    url: "https://login.microsoftonline.com/common/oauth2/authorize?client_id=c3728513-e7f6-497b-b319-619aa86f5b50&nonce=396527b8-f50b-49ea-a812-990cd07128bb&redirect_uri=https%3A%2F%2Fmy.epitech.eu%2Findex.html&response_type=id_token&state=",
                ),
            );

        if (this.results == null || this.prefs == null)
            return DefaultLayout(
                title: "Résultat des tests",
                child: Center(child: CircularProgressIndicator(),)
            );

        return DefaultLayout(
            title: "Résultat des tests",
            child: buildResults(context)
        );
    }
}