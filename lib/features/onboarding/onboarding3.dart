import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[600],
      body: Column(
        children: [
          SizedBox(
            height: 537.h,
            width: double.infinity,
            child: Image.asset(
              'assets/images/Photoroom.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsPalette.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    textAlign: TextAlign.center,
                    'Pick Up & Deliver with Ease',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 28.sp),
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    width: 361.w,
                    height: 40.h,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Use the built-in GPS and order timeline to complete pickups and deliver on time.',
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall!.copyWith(fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
