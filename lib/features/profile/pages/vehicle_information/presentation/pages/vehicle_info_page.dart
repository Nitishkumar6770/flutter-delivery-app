import 'dart:io';

import 'package:bitebuddie_new_version/core/common/basic_appbar.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:bitebuddie_new_version/features/profile/pages/vehicle_information/bloc/vehicle_info_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class VehicleInfoPage extends StatefulWidget {
  const VehicleInfoPage({super.key});

  @override
  State<VehicleInfoPage> createState() => _VehicleInfoPageState();
}

class _VehicleInfoPageState extends State<VehicleInfoPage> {
  final VehicleInfoBloc vehicleInfoBloc = VehicleInfoBloc();
  @override
  void initState() {
    vehicleInfoBloc.add(VehicleInfoFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('Vehicle Information', style: AppTheme.text20Bold),
        backarrowBG: ColorsPalette.black,
      ),

      body: Padding(
        padding: EdgeInsets.all(8.r),
        child: BlocBuilder<VehicleInfoBloc, VehicleInfoState>(
          bloc: vehicleInfoBloc,
          builder: (context, state) {
            if (state is VehicleInfoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is VehicleInfoLoaded) {
              final vehicleInfoLoaded = state.vehicleInfoResponse;
              return ListView(
                children: [
                  Text('Vehicle Type', style: AppTheme.text16Bold),
                  SizedBox(height: 8.h),
                  container(vehicleInfoLoaded.driver.vehicleType),
                  SizedBox(height: 20),
                  Text('Driving License', style: AppTheme.text16Bold),
                  SizedBox(height: 8.h),
                  dlContainer(vehicleInfoLoaded.driver.vehicleRc),
                  SizedBox(height: 20.h),
                  Text('Selected Area', style: AppTheme.text16Bold),
                  SizedBox(height: 8.h),
                  container(vehicleInfoLoaded.driver.cityName),
                ],
              );
            } else if (state is VehicleInfoError) {
              return Text(state.errorMessage);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget dlContainer(String text) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsPalette.appPrime),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 250.w,
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.text14Normal,
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                final dir = await getApplicationDocumentsDirectory();
                final path = '${dir.path}/vehicle_doc.pdf';

                await Dio().download(text, path);
                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     duration: Duration(seconds: 3),
                //     content: Text('Downloaded to: $path'),
                //   ),
                // );

                if (Platform.isAndroid || Platform.isIOS) {
                  await OpenFilex.open(path);
                }
              } catch (e) {
                Future.error(e);
              }
            },
            child: Text('View', style: TextStyle(color: ColorsPalette.red)),
          ),
        ],
      ),
    );
  }

  Widget container(String text) {
    return Container(
      width: double.infinity,
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: ColorsPalette.appPrime),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(text, style: AppTheme.text14Bold),
    );
  }
}
