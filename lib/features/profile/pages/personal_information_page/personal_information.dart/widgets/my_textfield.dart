import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MyTextfield extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final VoidCallback? onSuffixIconPressed;

//   const MyTextfield({
//     super.key,
//     this.hintText = '',
//     this.controller,
//     this.onSuffixIconPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       style: TextStyle(
//         color: ColorsPalette.black,
//         fontWeight: FontWeight.bold,
//         fontSize: 16.sp,
//       ),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: ColorsPalette.white,
//         hintText: hintText,
//         contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           borderSide: BorderSide(color: ColorsPalette.lightray, width: 1.w),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           borderSide: BorderSide(color: ColorsPalette.red, width: 1.w),
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(Icons.edit, color: ColorsPalette.red),
//           onPressed: onSuffixIconPressed,
//         ),
//       ),
//     );
//   }
// }
class MyTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;

  const MyTextfield({
    super.key,
    this.hintText = '',
    this.controller,
    this.onSuffixIconPressed,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSuffixPressed() {
    widget.controller?.clear();
    _focusNode.requestFocus(); 
    widget.onSuffixIconPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: TextStyle(
        color: ColorsPalette.black,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsPalette.white,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorsPalette.lightray, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: ColorsPalette.red, width: 1.w),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.edit, color: ColorsPalette.red),
          onPressed: _handleSuffixPressed,
        ),
      ),
    );
  }
}
