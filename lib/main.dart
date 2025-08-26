import 'package:bitebuddie_new_version/core/common/bottom_navbar.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // } on FirebaseException catch (e) {
  //   if (e.code != 'duplicate-app') rethrow;
  // }
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightMode,
          home: NavigationButton(),
        );
      },
    );
  }
}


































// // class MyApp extends StatelessWidget {
// //   final TextEditingController _controller = TextEditingController();

// //   MyApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Gemini AI Chat',
// //       home: Scaffold(
// //         appBar: AppBar(title: const Text('Gemini Chatbot')),
// //         body: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             children: [
// //               TextField(
// //                 controller: _controller,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Type your message',
// //                   border: OutlineInputBorder(),
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   final message = _controller.text.trim();
// //                   if (message.isNotEmpty) {
// //                     sendMessageToAI(message); // 👈 call your function here
// //                   }
// //                 },
// //                 child: const Text('Send to Gemini'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:bitebuddie_new_version/achatmodel/chat.dart';
// import 'package:flutter/material.dart';
// // ✅ Make sure this file is in the same directory or correct path

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final TextEditingController _controller = TextEditingController();
//   String _response = '';

//   void _sendToGemini() async {
//     final message = _controller.text.trim();
//     if (message.isEmpty) return;

//     setState(() {
//       _response = 'Thinking... 🤔';
//     });

//     final reply = await sendMessageToAI(message);

//     setState(() {
//       _response = reply;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Gemini AI Chat',
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Gemini Chatbot')),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(
//                     labelText: 'Type your message',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _sendToGemini,
//                   child: const Text('Send to Gemini'),
//                 ),
//                 const SizedBox(height: 24),
//                 Text(
//                   "AI Response:",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   _response,
//                   style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
