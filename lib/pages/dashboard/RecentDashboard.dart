import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentDashboard extends StatelessWidget {
    Notifications notifications;
    SharedPreferences prefs;

    /// AbsenceProfile Ctor
    RecentDashboard({Key key, @required this.notifications, @required this.prefs}) : super(key: key);

    @override
    Widget build(BuildContext context) {

        print(this.notifications.notifications.length);

        return ListView.builder(
            itemCount: this.notifications.notifications.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage((this.notifications.notifications[index].user.picture != null) ? this.prefs.getString("autolog_url") + "/file/userprofil/profilview/"
                                                        + this.notifications.notifications[index].user.picture.substring(
                                                            this.notifications.notifications[index].user.picture.lastIndexOf('/') + 1,
                                                            this.notifications.notifications[index].user.picture.length).replaceFirst(".bmp", ".jpg") :
                                                        "https://pbs.twimg.com/profile_images/681337437226938368/31sRHb4V_400x400.jpg"
                                                    )
                                                )
                                            )
                                        ),
                                    ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                            Container(
                                                width: MediaQuery.of(context).size.width - 100,
                                                child: Text(
                                                    this.notifications.notifications[index].title.substring(0, this.notifications.notifications[index].title.indexOf('<')),
                                                    style: TextStyle(fontSize: 10),
                                                ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context).size.width - 100,
                                                child: Text(
                                                    this.notifications.notifications[index].title.substring(this.notifications.notifications[index].title.indexOf('>') + 1,
                                                        this.notifications.notifications[index].title.indexOf("</")),
                                                    style: TextStyle(fontSize: 10),
                                                ),
                                            ),
                                        ],
                                    )
                                )
                            ],
                        ),
                    )
                );
            },
        );
    }
}