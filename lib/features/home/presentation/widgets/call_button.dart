import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 96.w,
      decoration: BoxDecoration(
        color: ColorsPalette.green,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: ColorsPalette.black.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: Offset(0, 2), 
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/callLogo.png', height: 20.h, width: 24.w
            ),
            Text(
              'Call',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: ColorsPalette.white),
            ),
          ],
        ),
      ),
    );
  }
}
