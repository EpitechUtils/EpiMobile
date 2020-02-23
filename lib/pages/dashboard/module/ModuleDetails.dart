import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
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
	    return DefaultLayout(
		child: Center(child: Icon(Icons.work, size: 100,)),
		title: "En cours de développement...",
		hasProfileButton: false,
	    );
	} else {

	}
    }
}