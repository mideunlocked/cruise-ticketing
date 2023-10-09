import 'package:cruise/helpers/format_number.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event_analysis.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({
    super.key,
    this.pricing,
    required this.data,
  });

  final dynamic pricing;
  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    final totalTickets = data.ticketQuantity;
    final ticketSold = data.ticketSold;
    final remainingTicket = totalTickets - ticketSold;
    var sizedBoxH2 = SizedBox(
      height: 2.h,
    );

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: CustomAppBar(
                title: "Analytics",
                bottomPadding: 2.h,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TicketsAnalysisCard(
                      remainingTicket: remainingTicket,
                      ticketSold: ticketSold,
                      totalTickets: totalTickets,
                    ),
                    sizedBoxH2,
                    RevenueAnalysis(
                      data: data,
                      pricing: pricing,
                    ),
                    sizedBoxH2,
                    TicketSalesCard(
                      data: data,
                      pricing: pricing,
                    ),
                    sizedBoxH2,
                    ConversionCard(data: data),
                    SizedBox(
                      height: 20.h,
                    ),
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

class ConversionCard extends StatelessWidget {
  const ConversionCard({
    super.key,
    required this.data,
  });

  final EventAnalysis data;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      color: Colors.white60,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
    );
    double conversionPercent = data.conversionPercentage();
    String percent = conversionPercent.toString();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 4.w,
        ),
        child: SizedBox(
          height: 40.h,
          width: 100.w,
          child: Column(
            children: [
              AnalysisCardTitle(
                title: "Event listing conversion rate",
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: PieChart(
                        swapAnimationCurve: Curves.easeIn,
                        swapAnimationDuration: const Duration(
                          seconds: 2,
                        ),
                        PieChartData(
                          sectionsSpace: 2.w,
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sections: [
                            PieChartSectionData(
                              value: data.totalViews.toDouble(),
                              title: "Views",
                              color: Colors.blue[900],
                              radius: 100,
                              titleStyle: textStyle,
                            ),
                            PieChartSectionData(
                              value: data.ticketSold.toDouble(),
                              title: "Sales",
                              color: Colors.green[900],
                              radius: 100,
                              titleStyle: textStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "$percent%",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15.sp,
                        color: conversionPercent < 40
                            ? Colors.red
                            : conversionPercent < 60
                                ? Colors.yellow
                                : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketSalesCard extends StatefulWidget {
  const TicketSalesCard({
    super.key,
    required this.data,
    this.pricing,
  });

  final EventAnalysis data;
  final dynamic pricing;

  @override
  State<TicketSalesCard> createState() => _TicketSalesCardState();
}

class _TicketSalesCardState extends State<TicketSalesCard> {
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<dynamic> tickeSalesData =
        widget.data.calculateTypeRevenue(widget.pricing);

    var sizedBox = SizedBox(
      height: 2.w,
    );
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
              sizedBox,
              sizedBox,
              SizedBox(
                height: 40.h,
                child: BarChart(
                  BarChartData(
                    backgroundColor: Colors.transparent,
                    maxY: widget.data.ticketSold.toDouble(),
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
                    barGroups: widget.data.soldTicketBreakdown
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
              ),
              SizedBox(
                height: 5.h,
              ),
              const AnalysisCardTitle(
                title: "Ticket revenue NGN",
              ),
              sizedBox,
              Column(
                children: tickeSalesData
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
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

  void increaseIndex() {
    if (initialIndex < widget.data.soldTicketBreakdown.length - 1) {
      initialIndex = initialIndex + 1;
    } else {
      initialIndex = 0;
    }
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    increaseIndex();

    Widget text = const Text("null");
    dynamic i;

    for (i in widget.data.soldTicketBreakdown) {
      if (i["id"] == initialIndex) {
        text = Text(
          i["type"].toString().split(" ").first,
        );
      }
    }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      space: 2,
      child: text,
    );
  }
}

class RevenueAnalysis extends StatelessWidget {
  const RevenueAnalysis({
    super.key,
    required this.data,
    required this.pricing,
  });

  final EventAnalysis data;
  final dynamic pricing;

  @override
  Widget build(BuildContext context) {
    dynamic typeRevenue = data.calculateTypeRevenue(pricing);
    double estimate = data.getEstimatedRevenue(pricing);
    double current = data.getCurrentRevenue(typeRevenue);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: SizedBox(
        height: 22.h,
        width: 100.w,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
          child: Column(
            children: [
              const AnalysisCardTitle(
                title: "Revenue (NGN)",
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RevenueTile(
                    data: estimate,
                    title: "Estimate",
                  ),
                  RevenueTile(
                    data: current,
                    title: "Current",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalysisCardTitle extends StatelessWidget {
  const AnalysisCardTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
      ),
    );
  }
}

class RevenueTile extends StatelessWidget {
  const RevenueTile({
    super.key,
    required this.data,
    required this.title,
  });

  final double data;
  final String title;

  @override
  Widget build(BuildContext context) {
    String dataString = FormatNumber.formatLargeNumber(
      data.toInt(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Text(
          dataString,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25.sp,
          ),
        ),
      ],
    );
  }
}

class TicketsAnalysisCard extends StatelessWidget {
  const TicketsAnalysisCard({
    super.key,
    required this.remainingTicket,
    required this.ticketSold,
    required this.totalTickets,
  });

  final int remainingTicket;
  final int ticketSold;
  final int totalTickets;

  @override
  Widget build(BuildContext context) {
    Color total = Theme.of(context).primaryColor;
    Color sold = Colors.green[900]!;
    Color left = Colors.yellow[900]!;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.w,
        ),
        child: SizedBox(
          height: 38.h,
          width: 100.w,
          child: Row(
            children: [
              Expanded(
                child: PieChart(
                  swapAnimationCurve: Curves.easeIn,
                  swapAnimationDuration: const Duration(
                    seconds: 2,
                  ),
                  PieChartData(
                    sectionsSpace: 2.w,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sections: [
                      PieChartSectionData(
                        value: remainingTicket.toDouble(),
                        color: left,
                        showTitle: false,
                        radius: 100,
                      ),
                      PieChartSectionData(
                        value: ticketSold.toDouble(),
                        color: sold,
                        showTitle: false,
                        radius: 100,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PieChartCustomValue(
                    data: totalTickets,
                    title: "Total Tickets",
                    totalChart: totalTickets,
                    showPercent: false,
                    iconColor: total,
                  ),
                  PieChartCustomValue(
                    data: ticketSold,
                    title: "Ticket(s) Sold",
                    totalChart: totalTickets,
                    iconColor: sold,
                  ),
                  PieChartCustomValue(
                    data: remainingTicket,
                    title: "Ticket(s) Left",
                    totalChart: totalTickets,
                    iconColor: left,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartCustomValue extends StatelessWidget {
  const PieChartCustomValue({
    super.key,
    required this.data,
    required this.title,
    required this.totalChart,
    required this.iconColor,
    this.showPercent = true,
  });

  final int data;
  final String title;
  final int totalChart;
  final Color iconColor;
  final bool showPercent;

  @override
  Widget build(BuildContext context) {
    double percentage = (data / totalChart) * 100;
    String approximatePercent = percentage.toStringAsFixed(2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.circle_rounded,
              color: iconColor,
              size: 10.sp,
            ),
            SizedBox(
              width: 3.sp,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              formatData(
                data,
              ),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(
              width: 3.sp,
            ),
            showPercent
                ? Text(
                    "($approximatePercent%)",
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }

  String formatData(int data) {
    String formatedData = FormatNumber.formatLargeNumber(data);

    return formatedData;
  }
}
