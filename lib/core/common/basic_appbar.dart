import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? flexibleSpace;
  final bool hideBack;
  final bool whiteIcon;
  final bool centerTitle;
  final Color appBarClr;
  final Color backBtnClr;
  final double appBarHeight;
  final Color? backarrowBG;
  final Color? iconColor;

  const BasicAppBar({
    this.backarrowBG,
    this.iconColor,
    this.hideBack = false,
    this.whiteIcon = false,
    this.flexibleSpace,
    this.title,
    this.centerTitle = false,
    this.appBarClr = Colors.transparent,
    this.backBtnClr = Colors.transparent,
    this.appBarHeight = kToolbarHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        flexibleSpace: flexibleSpace,
        backgroundColor: appBarClr,
        centerTitle: centerTitle,
        title: title ?? const Text(''),
        leading: hideBack
            ? null
            : Padding(
          padding: EdgeInsets.all(12.r),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            borderRadius: BorderRadius.circular(20.r),
            child: CircleAvatar(
              backgroundColor: backarrowBG ?? ColorsPalette.appPrime,
              child: Icon(
                Icons.arrow_back,
                color: iconColor ?? ColorsPalette.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}