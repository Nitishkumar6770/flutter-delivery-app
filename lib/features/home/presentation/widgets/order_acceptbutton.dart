import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderAcceptbutton extends StatelessWidget {
  final String buttonText;
  final Color color;
  final VoidCallback onPressed;

  const OrderAcceptbutton({
    super.key,
    required this.buttonText,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(79.w, 30.h),
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(
        buttonText,
        style: AppTheme.text16Bold.copyWith(color: ColorsPalette.white),
      ),
    );
  }
}
