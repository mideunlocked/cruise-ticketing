import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/event_analysis.dart';
import '../../widgets/analysis_widgets/age_distribution.dart';
import '../../widgets/analysis_widgets/conversion_card.dart';
import '../../widgets/analysis_widgets/device_distribution.dart';
import '../../widgets/analysis_widgets/gender_distribution.dart';
import '../../widgets/analysis_widgets/location_analysis_card.dart';
import '../../widgets/analysis_widgets/revenue_analysis.dart';
import '../../widgets/analysis_widgets/ticket_analysis_card.dart';
import '../../widgets/analysis_widgets/ticket_sales_card.dart';
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
    var sizedBoxH4 = SizedBox(
      height: 4.h,
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
                    sizedBoxH4,
                    RevenueAnalysis(
                      data: data,
                      pricing: pricing,
                    ),
                    sizedBoxH4,
                    TicketSalesCard(
                      data: data,
                      pricing: pricing,
                    ),
                    sizedBoxH4,
                    ConversionCard(data: data),
                    sizedBoxH4,
                    AgeDistribution(data: data),
                    sizedBoxH4,
                    GenderDistribution(data: data),
                    sizedBoxH4,
                    LocationAnalysisCard(data: data),
                    sizedBoxH4,
                    DeviceDistribution(data: data),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Analysis provided by Stact Platforms Inc.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black38,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
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
