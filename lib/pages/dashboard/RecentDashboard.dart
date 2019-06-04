import 'package:flutter/material.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';

class RecentDashboard extends StatelessWidget {
    Notifications notifications;

    /// AbsenceProfile Ctor
    RecentDashboard({Key key, @required this.notifications}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: this.notifications.notifications.length,
            itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Card(
                        child: Row(
                            children: <Widget>[
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        this.notifications.notifications[index].title.substring(
                                            this.notifications.notifications[index].title.indexOf('">') + 2,
                                            this.notifications.notifications[index].title.indexOf('</a'),
                                        ),
                                        style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                )
                            ],
                        ),
                    )
                );
            },
        );
    }
}