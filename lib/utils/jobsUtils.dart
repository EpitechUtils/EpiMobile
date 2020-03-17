import 'package:intl/intl.dart';
import 'package:mobile_intranet/parser/Parser.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notification/Notification.dart';
import 'package:mobile_intranet/parser/components/dashboard/Notifications.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleDay.dart';
import 'package:mobile_intranet/parser/components/schedule/ScheduleSession.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'configKey.dart' as ConfigurationKeys;
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:isolate';

// TODO implement cross dependent solution
// TODO Alarm manager for Android et backgound fetch for IOS

void processAndroidJobNotifications() {
    final int isolateId = Isolate.current.hashCode;

    print("Isolate: " + isolateId.toString());
    /*
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
        print("Get prefs...");
        Parser(prefs.getString("autolog_url")).parseDashboardNotifications().then((Notifications notifications) {
            print("Get request...");
            List<Notification> list = List<Notification>();

            if (prefs.getString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID) == null) {
                prefs.setString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID, notifications.notifications[0].id);
                // Send list
            }

            String lastId = prefs.getString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID);
            for (var n in notifications.notifications) {
                print("New notifs: " + n.title);
                if (n.id == lastId)
                    break;
                list.add(n);
            }
            prefs.setString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID, notifications.notifications[0].id);
            // Send list
        });
    });
    */
}

Future setupAndroidJob() async {
    final jobId = 0;

    await AndroidAlarmManager.initialize();
    await AndroidAlarmManager.periodic(const Duration(seconds: 10), jobId, processAndroidJobNotifications);
    return Future.value(true);
}

Future<List<Notification>> getNewNotifications(SharedPreferences prefs) async {
    Notifications notifications = await Parser(prefs.getString("autolog_url")).parseDashboardNotifications();
    List<Notification> list = List<Notification>();

    //TODO debug print
    if (prefs.getString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID) == null) {
        prefs.setString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID, notifications.notifications[0].id);
        return list;
    }

    String lastId = prefs.getString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID);
    for (var n in notifications.notifications) {
        if (n.id == lastId)
            break;
        list.add(n);
    }
    prefs.setString(ConfigurationKeys.CONFIG_KEY_NOTIFICATIONS_LAST_ID, notifications.notifications[0].id);
    return list;
}

Future<ScheduleSession> getNextSessionNotification(SharedPreferences prefs) async {
    ScheduleDay day = await Parser(prefs.getString("autolog_url")).parseScheduleDay(DateTime.now());

    for (var session in day.sessions) {
        var start = DateFormat("yyyy-MM-dd HH:mm:ss").parse(session.start);

        if (DateTime.now().difference(start).inMinutes <= 30 && !(session.eventRegistered is bool))
            return session;
    }
    return null;
}