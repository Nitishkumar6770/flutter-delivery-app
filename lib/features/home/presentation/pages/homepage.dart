import 'dart:async';
import 'package:bitebuddie_new_version/core/common/bottom_navbar.dart';
import 'package:bitebuddie_new_version/core/common/buttons/custom_elevated_button.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/features/home/presentation/bloc/home_bloc.dart';
import 'package:bitebuddie_new_version/features/home/presentation/widgets/order_acceptbutton.dart';
import 'package:bitebuddie_new_version/features/home/presentation/widgets/call_button.dart';
import 'package:bitebuddie_new_version/features/home/presentation/widgets/custom_dialogue.dart';
import 'package:bitebuddie_new_version/features/home/presentation/widgets/otp_textfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomepageMapState();
}

class _HomepageMapState extends State<HomePage> {
  bool orderAccepted = false;
  bool isOtpValid = false;
  LatLng? _currentLocation;
  bool _isLoadingLocation = true;
  bool _isMapCreated = false;
  bool _isMarkerLoaded = false;

  HomeBloc homeBloc = HomeBloc();

  final Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(20.3346, 60.8851),
    zoom: 14,
  );
  List<Marker> marker = [];
  final List<Marker> _list = [];

  @override
  void initState() {
    marker.addAll(_list);
    super.initState();
    _loadCustomMarker();
  }

  // marker for driver position in map
  BitmapDescriptor? customMarkerIcon;
  Future<void> _loadCustomMarker() async {
    customMarkerIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(90, 90)),
      'assets/images/drivermaplogo.png',
    );
    _isMarkerLoaded = true;
    setState(() {});
  }

  //   void _loadCustomMarker() async {
  //     customMarkerIcon = await BitmapDescriptor.asset(
  //       const ImageConfiguration(size: Size(90, 90)),
  //       'assets/images/drivermaplogo.png',
  //     );
  //     setState(() {});
  // }
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: homeBloc,
      listener: (context, state) {
        if (state is MapErrorState &&
            state.errorMessage.contains('permanently')) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Location permission denied permanently. Please enable it in settings.',
              ),
              action: SnackBarAction(
                label: 'Open Settings',
                onPressed: () {
                  AppSettings.openAppSettings(); // <- opens app settings
                },
              ),
            ),
          );
        } else if (state is MapErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          final bool isAvailable =
              (state is ToggleOnShowOrderPopUpState &&
                  state.availabilityResponse.isAvailable) ||
              (state is LiveLocationUpdated && state.isAvailable);

          if (state is LiveLocationUpdated) {
            if (!_isMarkerLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            _currentLocation = LatLng(state.lat, state.lng);
            _isLoadingLocation = false;

            marker = [
              Marker(
                markerId: MarkerId('driver_location'),
                position: _currentLocation!,
                icon: customMarkerIcon ?? BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: 'Hi Nitish'),
              ),
            ];

            if (_isMapCreated && _currentLocation != null) {
              Future.delayed(Duration(milliseconds: 300), () {
                _controller.future.then((mapController) {
                  mapController.animateCamera(
                    CameraUpdate.newLatLng(_currentLocation!),
                  );
                });
              });
            }
          }

          // if (state is LiveLocationUpdated) {
          //   _currentLocation = LatLng(state.lat, state.lng);
          //   _isLoadingLocation = false;

          //   // ✅ Update marker with custom icon
          //   marker = [
          //     Marker(
          //       markerId: MarkerId('driver_location'),
          //       position: _currentLocation!,
          //       icon: customMarkerIcon,
          //       infoWindow: InfoWindow(title: 'Hi Nitish'),
          //     ),
          //   ];

          //   // ✅ Avoid crash: only call animateCamera if controller is ready
          //   if (_isMapCreated && _currentLocation != null) {
          //     Future.delayed(Duration(milliseconds: 300), () {
          //       _controller.future.then((mapController) {
          //         mapController.animateCamera(
          //           CameraUpdate.newLatLng(_currentLocation!),
          //         );
          //       });
          //     });
          //   }
          // }
          return Scaffold(
            backgroundColor: ColorsPalette.white,
            appBar: AppBar(
              title: Text('Hi! Nitish Kumar'),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_rounded),
                  color: ColorsPalette.red,
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // status indicator
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 12.h,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                    color:
                                        isAvailable
                                            ? ColorsPalette.green
                                            : ColorsPalette.red,
                                    borderRadius: BorderRadius.circular(500.r),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  isAvailable
                                      ? "You're Online"
                                      : "You're Offline",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            isAvailable
                                ? SizedBox(
                                  width: 0.5.sw,
                                  child: Text(
                                    'Looking for new orders near you...',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                )
                                : SizedBox(
                                  width: 0.5.sw,
                                  child: Text(
                                    'Go online to start accepting delivery requests.',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                          ],
                        ),

                        // toggle button
                        GestureDetector(
                          onTap: () {
                            _isMapCreated = false;
                            homeBloc.add(ToggleAvailability());
                            _loadCustomMarker();
                            // fetchLocation();
                            print(isAvailable ? '1' : '2');
                          },
                          child: toggleAvailabilityButton(isAvailable),
                        ),
                      ],
                    ),
                  ),

                  // map and order popup
                  Expanded(
                    child: Stack(
                      children: [
                        if (!isAvailable)
                          // 🔹 User is offline — show default map without loader
                          GoogleMap(
                            initialCameraPosition: _cameraPosition,
                            markers: Set<Marker>.of(marker),
                            mapType: MapType.normal,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controller.isCompleted) {
                                _controller.complete(controller);
                              }
                              _isMapCreated = true;
                            },
                          )
                        else if (_isLoadingLocation)
                          // 🔄 Show loader when online and location not ready
                          Center(child: CircularProgressIndicator())
                        else
                          // ✅ Online and location is available
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target:
                                  _currentLocation ?? LatLng(20.3346, 60.8851),
                              zoom: 14,
                            ),
                            markers: Set<Marker>.of(marker),
                            mapType: MapType.normal,
                            mapToolbarEnabled: false,
                            zoomControlsEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              if (!_controller.isCompleted) {
                                _controller.complete(controller);
                              }
                              _isMapCreated = true;
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                orderAccepted
                    ? bottomSheetAfterAcceptingOrder()
                    : homeBottomSheet(isAvailable),
          );
        },
      ),
    );
  }

  // toggle button
  Widget toggleAvailabilityButton(bool isAvailable) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsPalette.white,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: isAvailable ? ColorsPalette.green : ColorsPalette.red,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsPalette.black.withValues(alpha: 0.4),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            isAvailable
                ? [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: ColorsPalette.white,
                    ),
                    child: Center(
                      child: Text(
                        'Offline',
                        style: TextStyle(
                          color: ColorsPalette.gray,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: ColorsPalette.green,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/Group.png',
                          height: 16.h,
                          width: 16.w,
                        ),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: ColorsPalette.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
                : [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: ColorsPalette.red,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/Group.png',
                          height: 16.h,
                          width: 16.w,
                        ),
                        Text(
                          'Offline',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.r),
                    child: Center(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          color: ColorsPalette.gray,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
      ),
    );
  }

  Widget homeBottomSheet(bool isAvailable) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsPalette.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.r),
          topRight: Radius.circular(15.r),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            spreadRadius: 2,
            color: ColorsPalette.black12,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s Progress',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 116.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorsPalette.white,
                    borderRadius: BorderRadius.circular(4.r),
                    boxShadow: [
                      BoxShadow(blurRadius: 4, color: ColorsPalette.black12),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildProgressCard('Today’s earning', '0'),
                      _buildProgressCard('Today’s Trip', '0'),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child:
                      isAvailable
                          ? Text(
                            'No active orders right now.',
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                          : Text(
                            'You are Currently Offline.',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                ),
                Center(
                  child:
                      isAvailable
                          ? Text(
                            'Stay online to receive delivery requests.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                          : Text(
                            'You won’t receive any delivery requests until you go online.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // todays progress report
  Widget _buildProgressCard(String title, String value) {
    return Container(
      height: 80.h,
      width: 156.w,
      decoration: BoxDecoration(
        color: ColorsPalette.lightYellow,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelMedium),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 20.sp),
          ),
        ],
      ),
    );
  }

  // the driver will get this pop up whenever he gets an order for delivery
  Widget orderReceivedPopUp() {
    return Container(
      margin: EdgeInsets.all(8.0.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorsPalette.yellow,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New order received!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Amount: ₹60',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 260.w,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Order from:',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal,
                            color: ColorsPalette.black,
                          ),
                        ),
                        TextSpan(
                          text: ' Indian Cottage',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Text('5 Items', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            SizedBox(height: 10.h),
            // for the dotted line
            dottedLine(),
            SizedBox(height: 10.h),
            Text(
              'Delivery details',
              style: GoogleFonts.nunitoSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                color: ColorsPalette.black,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Image.asset(
                  'assets/images/locationframe.png',
                  height: 18.h,
                  width: 18.w,
                ),
                SizedBox(width: 8.w),
                SizedBox(
                  width: 306.w,
                  child: Text(
                    '3rd floor, Dev Complex, Near Jagganath Temple, Pahala, khorda',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Image.asset(
                  'assets/images/phoneframe.png',
                  height: 18.h,
                  width: 18.h,
                ),
                SizedBox(width: 8.w),
                Text(
                  '+91 8986839735',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            dottedLine(),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/timerframe.png',
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '00:52',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Row(
                  children: [
                    OrderAcceptbutton(
                      buttonText: 'Reject',
                      color: ColorsPalette.red,
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder:
                              (context) => CustomDialog(
                                // imagePath: 'assets/images/Layer 28.svg',
                                title: 'Delivery Request Rejected',
                                content:
                                    'You’ve rejected the delivery request for Order from Indian Cottage.',
                                buttonText: 'Okay',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
                    OrderAcceptbutton(
                      buttonText: 'Accept',
                      color: ColorsPalette.green,
                      onPressed: () {
                        // print('screen height: $screenHeight');
                        // print('screen width: $screenWidth');
                        setState(() {
                          orderAccepted = true;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // bottomnavbar after accepting order
  Widget bottomSheetAfterAcceptingOrder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: [
          BoxShadow(blurRadius: 8, spreadRadius: 2, color: Colors.black12),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "PickUp by ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: "03:34 PM",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorsPalette.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "PickUp from ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: "Kake Da Minnar",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorsPalette.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "PickUp OTP: ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: "224567",
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(color: ColorsPalette.red),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Customer details',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      '5 items',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nitish Kumar',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      'Sub Total',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order no.: 6543435654',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '₹503',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  buttonText: 'Click After Pickup',
                  color: ColorsPalette.red,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => bottomSheetAfterOrderPickUp(),
                    );
                  },
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dottedLine() {
    return DottedBorder(
      options: CustomPathDottedBorderOptions(
        customPath:
            (size) =>
                Path()
                  ..moveTo(0, size.height / 2)
                  ..lineTo(size.width, size.height / 2),
        dashPattern: [10.w, 5.w], // width-aware dash spacing
        strokeWidth: 1.3.r, // responsive stroke width
        color: ColorsPalette.gray,
        padding: EdgeInsets.zero,
      ),
      child: SizedBox(
        width: double.infinity, // responsive height for the line
      ),
    );
  }

  // modal bottomnavbar after order pickup

  Widget bottomSheetAfterOrderPickUp() {
    return Container(
      margin: EdgeInsets.all(16.0).r,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Customer details',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Nitish Kumar',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              CallButton(),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Order no.: 6543435654',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 210.w,
                child: Text(
                  '3rd floor, Dev Complex, Near Jagganath Temple, Pahala, khorda',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Collect cash ₹503',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          dottedLine(),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order details',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text('5 Items', style: Theme.of(context).textTheme.labelMedium),
            ],
          ),
          SizedBox(height: 8.h),
          Text('1 Fried Rice', style: Theme.of(context).textTheme.titleSmall),
          Text(
            '2 Chocolate Cup Cake ',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text('2 Chilli fish', style: Theme.of(context).textTheme.titleSmall),
          Text('1 Garlic naan', style: Theme.of(context).textTheme.titleSmall),
          Text(
            '1 Crispy baby corn',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(height: 20.h),
          CustomElevatedButton(
            buttonText: 'Click After Delivery',
            color: ColorsPalette.red,
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                builder: (context) => bottomSheetAfterOrderDelivery(),
              );
            },
          ),
        ],
      ),
    );
  }

  // bottomnavbar for pick up with otp
  Widget bottomSheetAfterOrderDelivery() {
    return Container(
      margin: EdgeInsets.all(16.0.r),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Customer details',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Nitish Kumar',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              CallButton(),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            'Order no.: 6543435654',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 210.w,
                child: Text(
                  '3rd floor, Dev Complex, Near Jagganath Temple, Pahala, khorda ',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Column(
                children: [
                  Text(
                    'Payment Method',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    'Collect cash ₹503',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          dottedLine(),
          SizedBox(height: 8.h),
          Text(
            'Enter Delivery Code',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Please enter the 6-digit code provided by the customer to mark this order as delivered.',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          OtpTextfield(
            onOtpChanged: (bool isValid) {
              setState(() {
                isOtpValid = isValid;
              });
            },
          ),
          SizedBox(height: 15.h),
          CustomElevatedButton(
            buttonText: 'Confirm Delivery',
            color:
                isOtpValid
                    ? ColorsPalette.green
                    : ColorsPalette.inactiveElevatedbtn,
            textStyle: TextStyle(
              color: isOtpValid ? ColorsPalette.white : ColorsPalette.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              isOtpValid
                  ? showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder:
                        (context) => CustomDialog(
                          title: 'Delivery Confirmed!',
                          content:
                              "You’ve successfully delivered the order to Nitish Kumar.",
                          buttonText: 'Go to Home',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavigationButton(),
                              ),
                            );
                          },
                        ),
                  )
                  : showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder:
                        (context) => CustomDialog(
                          title: 'Incorrect OTP Entered!',
                          content:
                              "The OTP you entered is incorrect. Please recheck and provide the correct 6-digit code.",
                          buttonText: 'Try Again',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
