import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/loadingComponent.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/epitest/result.dart';
import 'package:mobile_intranet/parser/components/epitest/results.dart';
import 'package:mobile_intranet/utils/jwtParser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/pages/argos/resultInformation.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestsResultsPage extends StatefulWidget {

    TestsResultsPage({Key key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _TestsResultsPageState();
}

class _TestsResultsPageState extends State<TestsResultsPage> {

    // Title of the page
    final String title = "Résultats des tests (bêta)";

    // Class controllers
    final FlutterWebviewPlugin _webview = new FlutterWebviewPlugin();
    StreamSubscription<WebViewStateChanged> _onStateChanged;

    // Class fields
    bool _loaded = false;
    String _token;
    Results results;



    bool resetLocalStorage = false;
    String date = (DateTime.now().year - 1).toString();

    /// When activity closing
    @override
    void dispose() {
        this._onStateChanged.cancel();
        this._webview.dispose();
        super.dispose();
    }

    /// Init state and webview controller
    @override
    void initState() {
        super.initState();

        // Check if token exists and not expired
        SharedPreferences.getInstance().then((prefs) {
            if (prefs.getString("myepitech_token") != null) {
                int currentTimestamp = DateTime.now()
                    .subtract(Duration(minutes: 10)).millisecondsSinceEpoch;

                // Check for valid token
                if (prefs.getString("myepitech_token") != null
                    && prefs.getInt("myepitech_expire_at") < currentTimestamp) {
                    this.setState(() {
                        this._loaded = true;
                        this._token = prefs.getString("myepitech_token");
                    });
                    return;
                }

                // Token invalid
                prefs.remove("myepitech_token");
                prefs.remove("myepitech_expire_at");
            }

            this.setState(() => this._loaded = true);
        });

        this._webview.close();
        this._onStateChanged = _webview.onStateChanged.listen(this.onStateChanged);
    }

    /// When webview state is changed
    void onStateChanged(WebViewStateChanged state) async {
        if (state.url.startsWith("https://my.epitech.eu/index.html")) {
            if (state.type == WebViewState.finishLoad) {
                this._webview.hide();

                // Get shared preferences
                SharedPreferences.getInstance().then((prefs) {
                    // Parse query string and token to get expiration
                    String query = state.url.substring(state.url.indexOf('#') + 1);
                    Map<String, String> params = Uri.splitQueryString(query);
                    Map<String, dynamic> tokenPayload = JwtParser.parse(params['id_token']);
                    
                    // Store token and expiration token
                    prefs.setString("myepitech_token", params['id_token']);
                    prefs.setInt("myepitech_expire_at", tokenPayload['exp']);

                    // Close webview and parse results from API
                    Timer(Duration(seconds: 3), () {
                        this._webview.close();
                        this.parseResults(prefs.getString("autolog_url"), this.date).then((results) {
                            this.setState(() {
                                this._token = params['id_token'];
                                this.results = results;
                            });
                        });
                    });
                });
            }

        }
    }

    Future<Results> parseResults(String autolog, String year) {
        return Parser(autolog).parseEpitest(year, this._token);
    }

    /*Color getRadiusColor(double percent) {
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
    }*/

    /// Build results
    @override
    Widget build(BuildContext context) {
        if (!this._loaded)
            return LoadingComponent(title: this.title);

        // No token, display webview with connection
        if (this._token == null) {
            return DefaultLayout(
                title: "Résultat des tests (bêta)",
                child: WebviewScaffold(
                    withJavascript: true,
                    withZoom: false,
                    clearCache: true,
                    clearCookies: true,
                    debuggingEnabled: true,
                    url: "https://login.microsoftonline.com/common/oauth2/authorize"
                        "?client_id=c3728513-e7f6-497b-b319-619aa86f5b50"
                        "&nonce=8f4fc0ff-1886-4a50-a9da-b25e115aa94d"
                        "&redirect_uri=https%3A%2F%2Fmy.epitech.eu%2Findex.html"
                        "&response_type=id_token"
                    //"&state==",
                ),
            );
        }

        // Results loading
        if (this.results == null)
            return LoadingComponent(title: this.title);

        // Token found, great,
        return DefaultLayout(
            title: this.title,
            child: Container()
            //child: buildResults(context)
        );
    }
}