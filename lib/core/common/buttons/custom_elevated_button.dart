import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final Color color;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.textStyle,
    required this.buttonText,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 361.w,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text(
          buttonText,
          style:
              textStyle ??
              AppTheme.text16Bold.copyWith(color: ColorsPalette.white),
        ),
      ),
    );
  }
}
