import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingComponent extends StatelessWidget {

    final String title;

    LoadingComponent({@required this.title});

    static Widget getBody(BuildContext context) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                SpinKitThreeBounce(
                    color: Theme.of(context).primaryColor,
                    size: 30,
                )
            ],
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: this.title,
            child: getBody(context),
        );
    }
}