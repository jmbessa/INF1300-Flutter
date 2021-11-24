import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  // ignore: close_sinks
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  // static Future init({bool initScheduled = false}) async {
  //   final iOS = IOSInitializationSettings();
  //   final android = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   final settings = InitializationSettings(android: android, iOS: iOS);

  //   await _notifications.initialize(
  //     settings,
  //     onSelectNotification: (payload) async {
  //       onNotifications.add(payload);
  //     },
  //   );
  // }

  // void listenNotifications() =>
  //     NotificationApi.onNotifications.stream.listen(onClickedNotification);

  // void onClickedNotification(String? payload) => Navigator.of(context)
  //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
