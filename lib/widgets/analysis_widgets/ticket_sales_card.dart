import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../helpers/format_number.dart';
import '../../models/event_analysis.dart';
import 'analysis_card_title.dart';

class TicketSalesCard extends StatelessWidget {
  const TicketSalesCard({
    super.key,
    required this.data,
    this.pricing,
  });

  final EventAnalysis data;
  final dynamic pricing;

  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox(
      height: 2.w,
    );
    var sizedBoxH5 = SizedBox(
      height: 5.h,
    );
    List<dynamic> tickeSalesData = data.calculateTypeRevenue(pricing);
    Map<String, dynamic> popularTicket = data.getMostPopularTicketType();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
          child: Column(
            children: [
              const AnalysisCardTitle(
                title: "Ticket sales",
              ),
              sizedBoxH5,
              TicketBarChart(
                data: data.soldTicketBreakdown,
                ticketSold: data.ticketSold.toDouble(),
              ),
              sizedBoxH5,
              const AnalysisCardTitle(
                title: "Ticket revenue NGN",
              ),
              sizedBox,
              TicketRevenueBreakDown(
                data: tickeSalesData,
              ),
              sizedBoxH5,
              const AnalysisCardTitle(
                title: "Popular ticket type",
              ),
              sizedBox,
              PopularTicketType(
                data: popularTicket,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularTicketType extends StatelessWidget {
  const PopularTicketType({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const Text("No analysis yet")
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.entries.first.key,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
              Text(
                data.entries.first.value.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp,
                ),
              ),
            ],
          );
  }
}

class TicketRevenueBreakDown extends StatelessWidget {
  const TicketRevenueBreakDown({
    super.key,
    required this.data,
  });

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(
                bottom: 1.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${e["type"]}:",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    FormatNumber.formatLargeNumber(
                      int.parse(
                        e["value"].toString().split(".")[0],
                      ),
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class TicketBarChart extends StatefulWidget {
  const TicketBarChart({
    super.key,
    required this.data,
    required this.ticketSold,
  });

  final List<dynamic> data;
  final double ticketSold;

  @override
  State<TicketBarChart> createState() => _TicketBarChartState();
}

class _TicketBarChartState extends State<TicketBarChart> {
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: BarChart(
        BarChartData(
          backgroundColor: Colors.transparent,
          maxY: widget.ticketSold,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (
                  double value,
                  TitleMeta meta,
                ) {
                  return getBottomTiles(value, meta);
                },
              ),
            ),
          ),
          barGroups: widget.data
              .map(
                (e) => BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                        toY: double.parse(
                          e["value"].toString(),
                        ),
                        color: Colors.black,
                        width: 5.w,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(5),
                        ),
                        backDrawRodData: BackgroundBarChartRodData(
                          fromY: double.infinity,
                          show: true,
                          color: Colors.grey[200],
                        )),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void increaseIndex() {
    if (initialIndex < widget.data.length - 1) {
      initialIndex = initialIndex + 1;
    } else {
      initialIndex = 0;
    }
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    Widget text = const Text("null");
    dynamic i;

    for (i in widget.data) {
      if (i["id"] == initialIndex) {
        text = Text(
          i["type"].toString().split(" ").first,
        );
      }
    }

    increaseIndex();

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 2,
      child: text,
    );
  }
}
