import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding4 extends StatelessWidget {
  const Onboarding4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[600],
      body: Column(
        children: [
          SizedBox(
            height: 537.h,
            width: double.infinity,
            child: Image.asset('assets/images/image 9.png', fit: BoxFit.cover),
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
                    'Earn, Track & Grow',
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
                      'View your earnings, payouts, and performance directly from the app.',
                      style: AppTheme.text14Normal,
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
