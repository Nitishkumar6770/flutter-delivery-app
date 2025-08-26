import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/onboarding/onboarding_slides.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildBackgroundImage('assets/images/background1.jpg'),
          Center(
            child: SizedBox(
              width: 323.w,
              height: 280.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 27.w,
                    child: Image.asset(
                      'assets/images/bitebuddie_logo.png',
                      width: 266.w,
                      height: 266.h,
                    ),
                  ),
                  Positioned(
                    left: 39.w,
                    top: 168.h,
                    child: SizedBox(
                      height: 44.h,
                      width: 245.w,
                      child: Text(
                        textAlign: TextAlign.center,
                        'Delivery Partner',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 32.sp,
                          color: ColorsPalette.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: 815.h,
            left: 36.w,
            child: SizedBox(
              height: 48.h,
              width: 361.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsPalette.inactiveElevatedbtn,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageTransition(
                      duration: Duration(milliseconds: 500),
                      type: PageTransitionType.bottomToTop,
                      child: OnboardingSlides(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Getting Started',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the background image widget
  Widget buildBackgroundImage(String imagePath) {
    return Positioned.fill(
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
