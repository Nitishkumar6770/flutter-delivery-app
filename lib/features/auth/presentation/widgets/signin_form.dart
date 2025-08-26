// import 'package:flutter/material.dart';
//
// import '../bloc/signIn_bloc.dart';
// import '../bloc/signIn_event.dart';
// import '../bloc/signIn_state.dart';
// import 'package:bloc/bloc.dart';
//
//
// class SignInForm extends StatefulWidget {
//   final bool isLogin;
//
//   const SignInForm({super.key, required this.isLogin});
//
//   @override
//   State<SignInForm> createState() => _SignInFormState();
// }
//
//
//
// class _SignInFormState extends State<SignInForm> {
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool showOtpField = false;
//
//   void handleSubmit() {
//     if (!_formKey.currentState!.validate()) return;
//
//     final phone = mobileController.text.trim();
//     final otp = otpController.text.trim();
//
//     if (!showOtpField) {
//       context.read<SignInBloc>().add(SendOtpRequested(phone: phone, isLogin: widget.isLogin));
//     } else {
//       context.read<SignInBloc>().add(VerifyOtpRequested(phone: phone, otp: otp, isLogin: widget.isLogin));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//         child:BlocListener<SignInBloc, SignInState>(
//       listener: (context, state) {
//         if (state is SignInFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//         } else if (state is OtpSentState) {
//           setState(() => showOtpField = true);
//         }
//         // else if (state is SignInSuccess) {
//         //   Navigator.pushReplacement(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (_) => state.isLogin ? HomePage() : ProfilePage(),
//         //     ),
//         //   );
//         // }
//       },
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             TextFormField(
//               controller: mobileController,
//               maxLength: 10,
//               keyboardType: TextInputType.phone,
//               decoration: const InputDecoration(hintText: 'Enter mobile number', counterText: ""),
//               validator: (value) =>
//               value == null || value.length != 10 ? 'Must be 10 digits' : null,
//             ),
//             if (showOtpField)
//               TextFormField(
//                 controller: otpController,
//                 maxLength: 4,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(hintText: 'Enter OTP', counterText: ""),
//                 validator: (value) =>
//                 value == null || value.length != 4 ? 'Must be 4 digits' : null,
//               ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: handleSubmit,
//               child: Text(showOtpField ? (widget.isLogin ? 'Sign In' : 'Register') : 'Send OTP'),
//             ),
//           ],
//         ),
//       ),
//     ),
//     );
//   }
// }
