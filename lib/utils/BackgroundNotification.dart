import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/widgets.dart';

class BackgroundNotificationManager {
    static FlutterLocalNotificationsPlugin _localNotifications =
    FlutterLocalNotificationsPlugin();
    static Future<void> Function(String) _onSelect;

    static Future<void> _onSelectNotification(String payload) async {
        debugPrint("[Local Notifications]: Selected, payload `${payload}`");
        await _onSelect(payload);
        return;
    }

    static Future<void> _onFetch() async {
        //TODO make check for notifications here
        BackgroundNotificationManager.showActivityNotification(
                "C'est le titre", "C'est le corps");
        return;
    }

    static Future<void> _onBackgroundFetch() async {
        debugPrint("[Background Fetch]: Fetch occured");
        await _onFetch();
        BackgroundFetch.finish();
    }

    static Future<void> _onHeadlessBackgroundFetch() async {
        WidgetsFlutterBinding.ensureInitialized();
        debugPrint("[Background Fetch]: Headless fetch occured");
        await _onFetch();
        BackgroundFetch.finish();
    }

    static Future<void> initialize(
            Future<void> Function(String) onSelectNotification) async {
        WidgetsFlutterBinding.ensureInitialized();
        _onSelect = onSelectNotification;

        await BackgroundFetch.configure(
                BackgroundFetchConfig(
                    minimumFetchInterval: 15,
                    stopOnTerminate: false,
                    enableHeadless: true,
                    requiresBatteryNotLow: false,
                    requiresCharging: false,
                    requiresStorageNotLow: false,
                    requiresDeviceIdle: false,
                    startOnBoot: true,
                    requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_ANY,
                ),
                _onBackgroundFetch)
                .then((code) {
            debugPrint(
                    "[Background Fetch]: Initialisation successful, code `${code}`");
            BackgroundFetch.registerHeadlessTask(_onHeadlessBackgroundFetch).then(
                            (code) {
                        debugPrint(
                                "[Background Fetch]: Headless initialisation successful ? `${code}`");
                        _localNotifications
                                .initialize(
                                InitializationSettings(
                                        AndroidInitializationSettings('@mipmap/ic_launcher'),
                                        IOSInitializationSettings()),
                                onSelectNotification: _onSelectNotification)
                                .then(
                                        (success) => debugPrint(
                                        "[Local Notifications]: Initialisation successful ? `${success}`"),
                                onError: (e) => debugPrint(
                                        "[Local Notifications]: Error on initialisation `${e}`"));
                    }, onError: (e) {
                debugPrint(
                        "[Background Fetch]: Error on headless initialisation `${e}`");
            });
        }, onError: (e) {
            debugPrint("[Background Fetch]: Error on initialisation `${e}`");
        });
    }

    static Future<void> showActivityNotification(
            String title, String body) async {
        await _localNotifications
                .show(
            0,
            title,
            body,
            NotificationDetails(
                    AndroidNotificationDetails('epimobile-activity-channel-id',
                            'Activité', 'Une activité va bientôt avoir lieu',
                            playSound: false,
                            importance: Importance.High,
                            priority: Priority.High),
                    IOSNotificationDetails(presentSound: false)),
            payload: 'activity',
        )
                .then(
                        (success) => debugPrint(
                        "[Local Notifications]: Activity notification sent succefully`"),
                onError: (e) => debugPrint(
                        "[Local Notifications]: Error when sending activity notfication `${e}`"));
        return;
    }

    static Future<void> showNotificationNotification(String content) async {
        await _localNotifications
                .show(
            0,
            "Intra Notification",
            content,
            NotificationDetails(
                    AndroidNotificationDetails('epimobile-notification-channel-id',
                            'Notification Intra', "Une nouvelle notification sur l'intra",
                            playSound: false,
                            importance: Importance.High,
                            priority: Priority.High),
                    IOSNotificationDetails(presentSound: false)),
            payload: 'activity',
        )
                .then(
                        (success) => debugPrint(
                        "[Local Notifications]: Notification notification sent succefully`"),
                onError: (e) => debugPrint(
                        "[Local Notifications]: Error when sending notification notfication `${e}`"));
        return;
    }
}