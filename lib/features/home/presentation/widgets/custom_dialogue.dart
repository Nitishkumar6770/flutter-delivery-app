import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final String? imagePath;
  final VoidCallback onPressed;

  const CustomDialog({
    super.key,
    this.imagePath,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(24.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imagePath != null
              ? SvgPicture.asset(imagePath!, width: 30.w, height: 30.h)
              : SizedBox.shrink(),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 20.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: ColorsPalette.gray,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsPalette.yellow,
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 8.r),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              buttonText,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
