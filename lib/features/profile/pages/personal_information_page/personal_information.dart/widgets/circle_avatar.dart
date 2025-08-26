import 'dart:io';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileAvatarPicker extends StatefulWidget {
  const ProfileAvatarPicker({super.key});

  @override
  ProfileAvatarPickerState createState() => ProfileAvatarPickerState();
}

class ProfileAvatarPickerState extends State<ProfileAvatarPicker> {
  File? _image;

  Future<void> _pickImage() async {
    final permissionStatus = await Permission.photos.request();

    if (permissionStatus.isGranted) {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } else {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 70.r,
          backgroundImage:
              _image != null
                  ? FileImage(_image!)
                  : AssetImage('assets/images/bitebuddie_logo.png')
                      as ImageProvider,
        ),
        Positioned(
          bottom: 0.h,
          right: 4.w,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorsPalette.red,
              ),
              padding: EdgeInsets.all(8.r),
              child: Icon(Icons.camera_alt, color: ColorsPalette.white, size: 20.r),
            ),
          ),
        ),
      ],
    );
  }
}
