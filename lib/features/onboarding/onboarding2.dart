import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

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
              'assets/images/onboarding2.png',
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
                    'Accept Orders Near You',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 28.sp),
                  ),
                  SizedBox(height: 35.h),
                  Text(
                    textAlign: TextAlign.center,
                    'Get notified instantly when an order is ready from nearby restaurants or kitchens.',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 100.h
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
