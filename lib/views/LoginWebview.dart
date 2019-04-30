import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_intranet/utils/network/IntranetAPIUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWebview extends StatefulWidget {
    final String authUrl;

    /// Constructor
    LoginWebview({Key key, @required this.authUrl}) : super(key: key);

    @override
    _LoginWebview createState() => _LoginWebview();
}

class _LoginWebview extends State<LoginWebview> {

    //final Completer<WebViewController> _controller = Completer<WebViewController>();
    final IntranetAPIUtils _api = new IntranetAPIUtils();

    //StreamSubscription<WebViewStateChanged> _onStateChanged;

    /// Get authentication URL
    getAuthURL() async {
        var auth = await this._api.getAuthURL();
        if (auth == null || auth['office_auth_uri'] == null)
            return null;

        return auth;
    }

    /// Init state of the widget and configure webview
    @override
    void initState() {
        super.initState();
        //this._webviewConfig.close();

        // Get auth URL and set callback
        //this._onStateChanged = this._webviewConfig.onStateChanged.listen(this.onStateChanged);
        //debugPrint(widget.authUrl);
    }

    /// Called when the activity or screen are closed
    @override
    void dispose() {
        //this._onStateChanged.cancel();
        //this._webviewConfig.dispose();
        super.dispose();
    }

    /// Function called when the state of the webview is changed
    void onStateChanged(NavigationRequest request) {
        debugPrint(request.url);
        if (request.url.startsWith("https://intra.epitech.eu/")) {
            return;
            // Get autolog URL
            this._api.getAndSaveAutologinLink(request.url).then((res) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                debugPrint("zizi => " + res.toString());

                //this._webviewConfig.close();
            });

            //this.gotoLoginHomePage();
            //this._api.getAndSaveAutologinLink();
        }
    }

    /// Build widget and display content
    @override
    Widget build(BuildContext context) {
        return WebView(
            key: UniqueKey(),
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.authUrl,
            navigationDelegate: this.onStateChanged
        );
    }

}
