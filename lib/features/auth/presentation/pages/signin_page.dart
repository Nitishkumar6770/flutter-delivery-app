import 'package:bitebuddie_new_version/core/common/bottom_navbar.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/auth/presentation/pages/new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signIn_event.dart';
import '../bloc/signIn_state.dart';

class SignInPage extends StatefulWidget {
  // final String fcmToken;
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isLogin = true;
  bool showOtpField = false;
  // String whatChoosed = '';

  final SignInBloc signInBloc = SignInBloc();
  // final NotificationServices notificationServices = NotificationServices();

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // signInBloc = SignInBloc();
    super.initState();
    // notificationServices.firebase();
  }

  @override
  void dispose() {
    signInBloc.close();
    mobileController.dispose();
    otpController.dispose();
    super.dispose();
  }

  void handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final phone = mobileController.text.trim();
    final otp = otpController.text.trim();

    if (!showOtpField) {
      signInBloc.add(SendOtpRequested(phone: phone, isLogin: isLogin));
    } else {
      // final fcmToken = await FirebaseMessaging.instance.getToken();
      // print('fcmToken is : $fcmToken');
      signInBloc.add(
        VerifyOtpRequested(
          phone: phone,
          otp: otp,
          isLogin: isLogin,
          fcmToken: '',
        ),
      );
    }
  }

  void toggleTab(bool login) {
    setState(() {
      isLogin = login;
      showOtpField = false;
      mobileController.clear();
      otpController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInBloc, SignInState>(
        bloc: signInBloc,
        listener: (context, state) {
          if (state is SignInFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is OtpSentState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('OTP sent Successfully')));
            setState(() => showOtpField = true);
          } else if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('OTP verified Successfully')),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => isLogin ? NavigationButton() : NewPage(),
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 140),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: 220,
                        height: 220,
                        child: Image.asset(
                          'assets/images/bitebuddie_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        child: Text(
                          'Delivery Partner',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => toggleTab(true),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isLogin ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => toggleTab(false),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: !isLogin ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 2,
                      width: 140,
                      color: isLogin ? Colors.red : Colors.grey[300],
                    ),
                    Container(
                      height: 2,
                      width: 140,
                      color: !isLogin ? Colors.red : Colors.grey[300],
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Enter your phone number',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            hintText: 'Mobile Number',

                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            filled: true,
                            fillColor: ColorsPalette.white,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length != 10) {
                              return 'Mobile number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        if (showOtpField) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Enter the OTP',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            decoration: InputDecoration(
                              hintText:
                                  'Enter OTP sent to XXXXXXX${mobileController.text.length >= 3 ? mobileController.text.substring(mobileController.text.length - 3) : ''}',
                              counterText: '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length != 4) {
                                return 'OTP must be 4 digits';
                              }
                              return null;
                            },
                          ),
                        ],
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                // Spacer(flex: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsPalette.red,
                        foregroundColor: ColorsPalette.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          state is SignInLoading
                              ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                              : Text(
                                showOtpField
                                    ? (isLogin ? 'Sign In' : 'Register')
                                    : 'Send OTP',
                              ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
