import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_intranet/parser/components/dashboard/module/ModuleInformation.dart';

class ModuleDetails extends StatefulWidget {

    ModuleDetails({Key key}) : super(key: key);

    @override
    _ModuleDetails createState() => new _ModuleDetails();
}

class _ModuleDetails extends State<ModuleDetails> {
    SharedPreferences prefs;
    ModuleInformation moduleInformation;

    _ModuleDetails() {
        // -----------
    }

    @override
    Widget build(BuildContext context) {
	if (this.moduleInformation == null) {
	    return Scaffold(
		appBar: AppBar(
		    title: Text("Title")
		),
		body: CircularProgressIndicator()
	    );
	} else {
	    return Scaffold(
		appBar: AppBar(
		    title: Text("Title")
		),
		body: Text("Hello")
	    );
	}
    }
}