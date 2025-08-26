// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationServices {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   void firebaseInit() {
//     FirebaseMessaging.onMessage.listen((message) {
//       // print(message.notification!.title.toString());
//       // print(message.notification!.body.toString());
//     });
//   }

//   void requestPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       provisional: true,
//       sound: true,
//     );
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       // print('user grants permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       // print('user grants provisional permission');
//     } else {
//       // print('user denied permission');
//     }
//   }

//   Future<String> getDeviceToken() async {
//     String? token = await messaging.getToken();
//     return token!;
//   }

//   void isTokenRefresh() async {
//     messaging.onTokenRefresh.listen((event) {
//       event.toString();
//       // print('refresh');
//     });
//   }

//   void firebase() async {
//     firebaseInit();
//     requestPermission();
//     getDeviceToken();
//     isTokenRefresh();
//   }
// }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 