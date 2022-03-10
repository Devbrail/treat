import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:treat/shared/shared.dart';
import 'package:treat/shared/utils/common_function.dart';

import 'app_binding.dart';
import 'di.dart';
import 'lang/lang.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  await Firebase.initializeApp();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://fd6fdaa0b4de4dfc9f8f5ab573d5a8bd@o1127138.ingest.sentry.io/6170345';
      options.tracesSampleRate = 1.0;
      options.debug = kReleaseMode;
    },
    appRunner: () => runApp(App()),
  );
  // runApp(App());

  configLoading();
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    initFCM();
    super.initState();
  }

  initFCM() async {
    // NotificationSettings settings = await messaging.requestPermission(
    //   alert: true,
    //   announcement: false,
    //   badge: true,
    //   carPlay: false,
    //   criticalAlert: false,
    //   provisional: false,
    //   sound: true,
    // );
    // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //     print('Got a message whilst in the foreground!');
    //     print('Message data: ${message.data}');
    //     if (kReleaseMode)
    //       Sentry.captureMessage(
    //           'Notification recieved ${message.data} ${message.notification}');
    //     if (message.notification != null) {
    //       print(
    //           'Message also contained a notification: ${message.notification}');
    //     }
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: true,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: 'Treat App',
      theme: ThemeConfig.lightTheme,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  Utils.setStatusBarColor();
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0

    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.lightGray
    ..indicatorColor = ColorConstants.violet
    ..textColor = ColorConstants.violet
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
