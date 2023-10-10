import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'piechart_custom_value.dart';

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
