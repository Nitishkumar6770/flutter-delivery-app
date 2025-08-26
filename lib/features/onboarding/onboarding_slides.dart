import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/auth/presentation/pages/signin_page.dart';
import 'package:bitebuddie_new_version/features/onboarding/onboarding2.dart';
import 'package:bitebuddie_new_version/features/onboarding/onboarding3.dart';
import 'package:bitebuddie_new_version/features/onboarding/onboarding4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingSlides extends StatefulWidget {
  const OnboardingSlides({super.key});

  @override
  State<OnboardingSlides> createState() => _OnboardingSlidesState();
}

class _OnboardingSlidesState extends State<OnboardingSlides> {
  final pageController = PageController();
  int currentIndex = 0;
  String btnText = 'Skip';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [Onboarding2(), Onboarding3(), Onboarding4()],
          ),
          Positioned(
            top: 555.h,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotColor: ColorsPalette.yellow,
                  activeDotColor: ColorsPalette.yellow,
                  dotHeight: 12.r,
                  dotWidth: 12.r,
                ),
              ),
            ),
          ),
          Positioned(
            left: 36.w,
            top: 815.h,
            child: SizedBox(
              height: 48.h,
              width: 361.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      currentIndex == 2
                          ? ColorsPalette.red
                          : ColorsPalette.inactiveElevatedbtn,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  if (btnText == 'Skip') {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: SignInPage(),
                      ),
                      (route) => false,
                    );
                  }
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child:
                    currentIndex == 2
                        ? Text(
                          'Sign in / Register',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(
                            fontSize: 20.sp,
                            color: ColorsPalette.white,
                          ),
                        )
                        : Text(
                          btnText,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(fontSize: 20.sp),
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
