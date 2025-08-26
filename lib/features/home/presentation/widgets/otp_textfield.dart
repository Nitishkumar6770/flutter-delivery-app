import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpTextfield extends StatefulWidget {
  final void Function(bool isValid) onOtpChanged;

  const OtpTextfield({super.key, required this.onOtpChanged});

  @override
  State<OtpTextfield> createState() => _OtpTextfieldState();
}

class _OtpTextfieldState extends State<OtpTextfield> {
  final int otpLength = 6;
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleInput(String value, int index) {
    if (value.isNotEmpty && index < otpLength - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    }

    final allFilled = _controllers.every((c) => c.text.trim().isNotEmpty);
    widget.onOtpChanged(allFilled); // notify parent
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(otpLength, (index) {
        return SizedBox(
          width: 40.w,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontSize: 20.sp),
            decoration: InputDecoration(
              counterText: '',
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsPalette.gray,
                  width: 2.w,
                  style: BorderStyle.solid,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: ColorsPalette.black,
                  width: 2.w,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            onChanged: (value) => _handleInput(value, index),
          ),
        );
      }),
    );
  }
}
