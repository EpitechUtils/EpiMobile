import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModulesDashboard extends StatefulWidget {
    Dashboard dashboard;
    SharedPreferences prefs;

    ModulesDashboard({Key key, @required this.dashboard, @required this.prefs}) : super(key: key);

    @override
    _ModulesDashboard createState() => new _ModulesDashboard();
}

class _ModulesDashboard extends State<ModulesDashboard> {

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: this.widget.dashboard.modules.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Text(this.widget.dashboard.modules[index].name),
                );
            },
        );
    }
}