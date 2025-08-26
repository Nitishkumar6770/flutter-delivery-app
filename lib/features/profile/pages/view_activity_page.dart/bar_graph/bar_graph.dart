import 'package:bitebuddie_new_version/core/theme/colors/colorpalette.dart';
import 'package:bitebuddie_new_version/core/theme/themes.dart';
import 'package:bitebuddie_new_version/features/profile/pages/view_activity_page.dart/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;
  const MyBarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thuAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 40,
        minY: 0,
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(color: ColorsPalette.black, width: 1.w),
            left: BorderSide(color: ColorsPalette.black, width: 1.w),
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40.h,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),



























        gridData: FlGridData(show: false),
        barGroups:
            myBarData.barData
                .map(
                  (data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y,
                        color: ColorsPalette.yellow,
                        width: 28.w,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.r),
                          topRight: Radius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  final style = AppTheme.text14Normal;
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('Sun', style: style);
      break;
    case 1:
      text = Text('Mon', style: style);
      break;
    case 2:
      text = Text('Tue', style: style);
      break;
    case 3:
      text = Text('Wed', style: style);
      break;
    case 4:
      text = Text('Thu', style: style);
      break;
    case 5:
      text = Text('Fri', style: style);
      break;
    case 6:
      text = Text('Sun', style: style);
      break;
    default:
      return Text('', style: style);
  }
  return SideTitleWidget(meta: meta, child: text);
}
