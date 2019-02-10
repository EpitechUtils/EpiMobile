import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/components/buttons/CustomIconButton.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:mobile_intranet/utils/network/NetworkUtils.dart';

class LoginPage extends StatefulWidget {
  final String title;

  LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
    final _webviewConfig = new FlutterWebviewPlugin();

    StreamSubscription<WebViewStateChanged> _onStateChanged;

    AnimationController _animationController;
    IntranetAPIUtils _api = new IntranetAPIUtils();
    String _authUrl;

    PageController _controller = new PageController(initialPage: 1, viewportFraction: 1.0);

    @override
    void dispose() {
        //this._onDestroy.cancel();
        this._onStateChanged.cancel();

        // Destroy configurations
        this._animationController.dispose();
        this._webviewConfig.dispose();
        super.dispose();
    }

    @override
    void initState() {
        super.initState();
        this._webviewConfig.close();

        // Init animation
        this._animationController = new AnimationController(
            vsync: this,
            duration: Duration(seconds: 1)
        );
        this._animationController.repeat();

        // Get login url from intranet
        this._api.getAuthURL().then((auth) {
            this.setState(() {
                if (auth == null || auth['office_auth_uri'] == null) {
                    this._authUrl = null;
                    return;
                }

                this._authUrl = auth['office_auth_uri'];
            });
        });

        // Configure listeners
        this._onStateChanged = this._webviewConfig.onStateChanged.listen(this.onStateChanged);
    }

    void onStateChanged(WebViewStateChanged state) {
        if (state.url.startsWith("https://intra.epitech.eu/auth/office365")) {
            print("Redirect URI => " + state.url);
            this._webviewConfig.close();

            // Login with office redirect uri and stock autologin URI to cache
            this._api.getAndSaveAutologinLink(state.url)
                .then((res) {
                    print("zizi => " + res.toString());
                    this.gotoLoginHomePage();
                });

            //this.gotoLoginHomePage();
            //this._api.getAndSaveAutologinLink();
        }
    }

    Widget connectionButton() {
        // Fetch login url from intranet API
        if (this._authUrl == null) {
            return OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)
                ),
                color: Colors.white,
                onPressed: this.gotoLoginWebView,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                            Container(
                                margin: EdgeInsets.only(right: 5.0),
                                child: AnimatedBuilder(
                                    animation: this._animationController,
                                    child: Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                    ),
                                    builder: (BuildContext context, Widget _widget) {
                                        return Transform.rotate(
                                            angle: this._animationController.value * 6.3,
                                            child: _widget
                                        );
                                    }
                                )
                            ),

                            Text("Chargement en cours...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )
                        ]
                    )
                )
            );
        }

        // Url founded, not loading
        return OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
            ),
            color: Colors.white,
            onPressed: this.gotoLoginWebView,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Expanded(
                            child: Text("Connexion Office365",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                )
                            )
                        )
                    ]
                )
            )
        );
    }

    Widget loginHomepage() {
        return Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                color: Colors.white12,
                image: DecorationImage(
                    colorFilter:
                        new ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
                    image: AssetImage("assets/images/login-background.jpg"),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
                children: <Widget>[

                    // Icon
                    Container(
                        padding: EdgeInsets.only(top: 220.0),
                        child: Center(
                            child: Icon(
                                Icons.people,
                                color: Colors.white,
                                size: 120.0
                            )
                        )
                    ),

                    /// App name
                    Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                                /// Normal text
                                Text("Epitech",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontFamily: 'icomoon'
                                    )
                                ),

                                /// Bolded text
                                Text(" Intranet",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35.0,
                                        fontFamily: 'icomoon',
                                        fontWeight: FontWeight.bold
                                    )
                                )
                            ],
                        )
                    ),

                    /// Connect to office365 button
                    Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 120.0),
                        child: new Row(
                            children: <Widget>[

                                new Expanded(
                                    child: this.connectionButton()
                                ),
                            ]
                        )
                    )
                ],
            )
        );
    }

    Widget loginWebview() {
        return WebviewScaffold(
            withJavascript: true,
            appBar: AppBar(
                title: Text("Connexion Office365"),
                centerTitle: true,
                actions: <Widget>[

                    Container(
                        child: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: Colors.white,
                            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                            onPressed: this.gotoLoginHomePage
                        )
                    )

                ],
            ),
            url: this._authUrl,
            clearCookies: true,
            clearCache: true,
            appCacheEnabled: true,
            //scrollBar: false
        );

        return Scaffold(
            appBar: AppBar(
                title: Text("Connexion Office365"),
                centerTitle: true,
                actions: <Widget>[

                    Container(
                        child: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            color: Colors.white,
                            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                            onPressed: this.gotoLoginHomePage
                        )
                    )

                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        // Check if the
        //if ()
        return Container(
            height: MediaQuery.of(context).size.height,
            child: PageView(
                controller: this._controller,
                physics: new AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                    this.loginWebview(),
                    this.loginHomepage()
                ],
                scrollDirection: Axis.horizontal
            )
        );
    }

    void gotoLoginWebView() {
        this._controller.animateToPage(0,
            duration: Duration(milliseconds: 550),
            curve: Curves.bounceOut
        );
    }

    void gotoLoginHomePage() {
        this._controller.animateToPage(1,
            duration: Duration(milliseconds:550),
            curve: Curves.bounceOut
        );
    }

}
