import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';

import '../../../auth/data/models/user.dart';
import '../../app_logger.dart';
import 'notifications.dart';

// TODO: This needs to be fully refactored
class NotificationsImpl extends Notifications {
  @override
  Future<UserDeviceNotificationsToken> getUserDeviceToken() async {
    const newOneSignalToken = '';
    var newFirebaseToken = '';

    try {
      // newOneSignalToken = OneSignal.User.pushSubscription.id ?? '';
      newFirebaseToken = await FirebaseMessaging.instance.getToken() ?? '';
    } catch (e) {
      AppLogger.error(e.toString(), error: e);
    }

    return UserDeviceNotificationsToken(
      firebase: newFirebaseToken,
      oneSignal: newOneSignalToken,
    );
  }

  @override
  Future<void> registerNotificationsHandlers(BuildContext context) async {
    // if (!PlatformChecker.nativePlatform().isMobile()) return;

    // OneSignal.Notifications.addClickListener((event) {
    //   // ref
    //   //     .read(NotificationNotififer.notificationsProvider.notifier)
    //   //     .addNotificationFromPushNotification(
    //   //       MyAppNotification.fromOneSignal(event.notification),
    // });
    // void foregroundWillDisplayListener(OSNotificationWillDisplayEvent event) {
    //   // TODO: Replace this with bloc
    //   // conte
    //   //     .read(NotificationNotififer.notificationsProvider.notifier)
    //   //     .addNotificationFromPushNotification(
    //   //       MyAppNotification.fromOneSignal(event.notification),
    //   //     );
    //   AdaptiveMessenger.showPlatformMessage(
    //       context: context,
    //       message: '${event.notification.title} in foreground');
    // }

    // OneSignal.Notifications.removeForegroundWillDisplayListener(
    //     foregroundWillDisplayListener);
    // OneSignal.Notifications.addForegroundWillDisplayListener(
    //     foregroundWillDisplayListener);
  }
}
