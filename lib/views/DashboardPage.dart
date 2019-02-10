import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
    DashboardPage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

    @override
    Widget build(BuildContext context) {
        return Container(
            child: Text("bite")
        );
    }

}
