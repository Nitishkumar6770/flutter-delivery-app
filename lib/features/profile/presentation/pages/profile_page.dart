import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:bitebuddie_new_version/features/profile/pages/personal_information_page/personal_information.dart/presentation/my_information.dart';
import 'package:bitebuddie_new_version/features/profile/pages/view_activity_page.dart/activity_page.dart';
import 'package:bitebuddie_new_version/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import '../../../auth/presentation/pages/new.dart';
import '../../pages/vehicle_information/presentation/pages/vehicle_info_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileBloc _profileBloc = ProfileBloc();
  // NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    super.initState();
    _profileBloc.add(ProfileInitialEvent());
    // // notificationServices.firebase();
    // notificationServices.firebaseInit();
    // notificationServices.requestPermission();
    // notificationServices.isTokenRefresh();
    // notificationServices.getDeviceToken().then((value) {
    //   print('device token: $value');
    // });
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Log out'),
            content: Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Logged out')));
                },
                child: Text('Log out'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsPalette.white,
      appBar: AppBar(title: Text('Profile', style: AppTheme.text20Bold)),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final driver = state.driver;
            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: ColorsPalette.veryLightOrange,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                          backgroundColor: ColorsPalette.primary,
                          backgroundImage: NetworkImage(driver.driver.imageUrl),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                driver.driver.name,
                                style: AppTheme.text16Bold,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Driver ID: ${driver.driver.id}',
                                style: AppTheme.text12Normal,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                driver.driver.email,
                                style: AppTheme.text12Normal,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '+91 ${driver.driver.phone}',
                                style: AppTheme.text12Normal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: ViewActivityPage(),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.access_time, color: ColorsPalette.black),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'View activity',
                              style: AppTheme.text16Bold,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MyInformation(),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.person_outline_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Personal Information',
                              style: AppTheme.text16Bold,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: VehicleInfoPage(),
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.two_wheeler_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Vehicle Information',
                              style: AppTheme.text16Bold,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NewPage()),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'My earnings',
                              style: AppTheme.text16Bold,
                            ),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NewPage()),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text('Settings', style: AppTheme.text16Bold),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NewPage()),
                      );
                    },
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ColorsPalette.divider,
                            width: 0.2.w,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.contact_support_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text('Support', style: AppTheme.text16Bold),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: _showLogoutConfirmation,
                    child: Container(
                      width: 360.w,
                      height: 60.h,
                      padding: EdgeInsets.all(10.r),
                      child: Row(
                        children: [
                          Icon(
                            Icons.power_settings_new_outlined,
                            color: ColorsPalette.black,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text('Log out', style: AppTheme.text16Bold),
                          ),
                          Icon(Icons.chevron_right, color: ColorsPalette.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
