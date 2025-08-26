import 'package:bitebuddie_new_version/core/common/basic_appbar.dart';
import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:bitebuddie_new_version/features/profile/pages/view_activity_page.dart/bar_graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewActivityPage extends StatefulWidget {
  const ViewActivityPage({super.key});

  @override
  State<ViewActivityPage> createState() => _ViewActivityPageState();
}

class _ViewActivityPageState extends State<ViewActivityPage> {
  List<double> weeklySummary = [30.0, 22.0, 12.0, 16.0, 7.0, 11.0, 4.0];
  String selectedValue = 'Week';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('View Activity', style: AppTheme.text20Bold),
        backarrowBG: ColorsPalette.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.r),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: ColorsPalette.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsPalette.gray.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Deliveries',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: ColorsPalette.red,
                              width: 1.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedValue,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                PopupMenuButton<String>(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: ColorsPalette.black,
                                  ),
                                  onSelected: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                  itemBuilder:
                                      (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'Week',
                                              child: Text('Week'),
                                            ),
                                            const PopupMenuItem<String>(
                                              value: 'Month',
                                              child: Text('Month'),
                                            ),
                                          ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 240.h,
                      width: 461.w,
                      child: MyBarGraph(weeklySummary: weeklySummary),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsPalette.white,
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsPalette.gray.withValues(alpha: 0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Delivery completed: ",
                            style: AppTheme.text16medium,
                          ),
                          TextSpan(
                            text: "60",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Delivery rejected:  ",
                            style: AppTheme.text16medium,
                          ),
                          TextSpan(
                            text: "13 ",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Average Delivery Time: ",
                            style: AppTheme.text16medium,
                          ),
                          TextSpan(
                            text: "13 mins",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Rating: ",
                            style: AppTheme.text16medium,
                          ),
                          TextSpan(
                            text: "4.6 ★",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Earnings This Week: ",
                            style: AppTheme.text16medium,
                          ),
                          TextSpan(
                            text: " ₹1070",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
