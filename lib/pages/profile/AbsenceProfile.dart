import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/profile/Profile.dart';

class AbsenceProfile extends StatelessWidget {
    final Profile profile;

    /// AbsenceProfile Ctor
    AbsenceProfile({Key key, @required this.profile}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: this.profile.missed.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                        child: Column(
                            children: <Widget>[
                                Container(
                                    child: Text(
                                        this.profile.missed[index]["categ_title"].toString() + " le " + this.profile.missed[index]["begin"],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600
                                        )
                                    ),
                                    margin: EdgeInsets.only(bottom: 10),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                        Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                (this.profile.missed[index]["acti_title"].toString().length > 50) ?
                                                this.profile.missed[index]["acti_title"].toString().substring(0, 50) + "..." : this.profile.missed[index]["acti_title"],
                                                style: TextStyle(
                                                    fontStyle: FontStyle.italic
                                                ),
                                            ),
                                        )
                                    ],
                                )
                            ],
                        ),
                    ),
                );
            }
        );
    }
}