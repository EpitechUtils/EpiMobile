import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/Profile/Profile.dart';

class MarksProfile extends StatelessWidget {
    final Profile profile;

    MarksProfile({Key key, @required this.profile}) : super(key: key);

    @override
    Widget build(BuildContext context) {
	return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
                return Text(this.profile.marks[index].name + " :  "  + ((this.profile.marks[index].mark == null) ? "?" : this.profile.marks[index].mark.toStringAsFixed(this.profile.marks[index].mark.truncateToDouble() == this.profile.marks[index].mark ? 0 : 1)));
            },
            itemCount: this.profile.marks.length,
        );
    }
}