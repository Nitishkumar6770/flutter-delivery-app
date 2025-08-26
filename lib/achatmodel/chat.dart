// // chat.dart
// import 'package:google_generative_ai/google_generative_ai.dart';

// final model = GenerativeModel(
//   model: 'gemini-1.5-flash',
//   apiKey: 'AIzaSyBvI98teG_jPwWuspPYIhUtLLxrwx21u6s',
// );

// Future<String> sendMessageToAI(String message) async {
//   try {
//     print('🟡 Sending to Gemini: $message');
//     final chat = model.startChat();
//     final response = await chat.sendMessage(Content.text(message));
//     final reply = response.text ?? 'No response';
//     print('🟢 AI Response: $reply');
//     return reply;
//   } catch (error) {
//     print('🔴 Gemini API Error: $error');
//     return 'Error: $error';
//   }
// }
