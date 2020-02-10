import 'package:flutter/material.dart';
import 'package:mobile_intranet/layouts/default.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationsPageState();

}

class _NotificationsPageState extends State<NotificationsPage> {
    Notifications notifications;
    SharedPreferences prefs;

    _NotificationsPageState() {
        SharedPreferences.getInstance().then((SharedPreferences prefs) => this.setState(() {
            this.prefs = prefs;
            Parser parser = Parser(prefs.getString("autolog_url"));

            parser.parseDashboardNotifications().then((Notifications notifications) => this.setState(() {
                this.notifications = notifications;

                int index = 0;
                for (var item in this.notifications.notifications) {
                    String title;
                    String subtitle;

                    title = (item.title.contains('<')) ? item.title.substring(0, item.title.indexOf('<')) : item.title;
                    subtitle = (item.title.contains('<')) ? item.title.substring(item.title.indexOf('>') + 1, item.title.lastIndexOf('<')) : "";
                    if (subtitle.isNotEmpty && subtitle.contains('<')) {
                        subtitle = subtitle.substring(0, subtitle.indexOf('<'));
                    }
                    this.notifications.notifications[index].title = title + "|" + subtitle;
                    index++;
                }
            }));
        }));
    }

    Widget createNotificationsList(BuildContext context) {
        if (this.notifications == null) {
            return Center(child: CircularProgressIndicator());
        }
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
                                                    this.notifications.notifications[index].title.split('|')[0],
                                                    style: TextStyle(fontSize: 10),
                                                ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context).size.width - 100,
                                                child: Text(
                                                    this.notifications.notifications[index].title.split('|')[1],
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

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Notifications",
            child: createNotificationsList(context),
        );
    }
}