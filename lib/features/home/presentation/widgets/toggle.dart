import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnlineStatusToggle extends StatelessWidget {
  final VoidCallback onTap;
  final bool isOnline;
  final Color borderColor;
  final Color activeColor;
  final Color inactiveColor;
  final String activeLabel;
  final String inactiveLabel;

  const OnlineStatusToggle({
    super.key,
    required this.onTap,
    required this.isOnline,
    required this.borderColor,
    required this.activeColor,
    required this.inactiveColor,
    required this.activeLabel,
    required this.inactiveLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        width: 144.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: borderColor, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: ColorsPalette.black.withAlpha(40),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 71.w,
              height: 38.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: isOnline ? inactiveColor : activeColor,
              ),
              child:
                  isOnline
                      ? Center(
                        child: Text(
                          inactiveLabel,
                          style: TextStyle(
                            color: ColorsPalette.gray,
                            fontSize: 12.sp,
                          ),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/Group.png',
                            height: 16.h,
                            width: 16.w,
                          ),
                          Text(
                            activeLabel,
                            style: TextStyle(
                              color: ColorsPalette.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
            ),
            Container(
              width: 71.w,
              height: 38.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.r),
                color: isOnline ? activeColor : ColorsPalette.white,
              ),
              child:
                  isOnline
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/Group.png',
                            height: 16.h,
                            width: 16.w,
                          ),
                          Text(
                            activeLabel,
                            style: TextStyle(
                              color: ColorsPalette.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                      : Center(
                        child: Text(
                          inactiveLabel,
                          style: TextStyle(
                            color: ColorsPalette.gray,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
