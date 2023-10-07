import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/ticket_type.dart';
import '../../widgets/create_event_widgets/text_field_title.dart';
import '../../widgets/event_screen_widgets/event_screen_title_widget.dart';

class Step5 extends StatefulWidget {
  const Step5({
    super.key,
    // required this.pricings,
    required this.formKey,
    required this.getFunction,
  });

  // final List<Pricing> pricings;
  final Function(List<Pricing>) getFunction;
  final GlobalKey<FormState> formKey;

  @override
  State<Step5> createState() => _Step4State();
}

class _Step4State extends State<Step5> {
  bool isFree = true;

  List<Pricing> pricings = [];

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventScreenTitleWidget(title: "Ticket pricing"),
          SizedBox(
            height: 5.h,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pricings.length + 1,
              itemBuilder: (ctx, index) {
                if (index == pricings.length) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pricings.add(
                          Pricing(
                            category: '',
                            price: 0.0,
                            quantity: 0,
                          ),
                        );
                        widget.getFunction(pricings);
                      });
                      print(pricings[0].category);
                    },
                    child: const Text('Add Ticket'),
                  );
                }
                final pricing = pricings[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ticket number: ${index + 1}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: primaryColor.withOpacity(0.7),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              pricings.removeAt(index);
                              widget.getFunction(pricings);
                            });
                          },
                          child: const Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    const TextFieldTitle(title: "CATEGORY"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter ticket category e.g Regular",
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            pricing.category = value;
                            widget.getFunction(pricings);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Category name is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const TextFieldTitle(title: "PRICE"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter category price",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            pricing.price = double.parse(value);
                            widget.getFunction(pricings);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Price is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const TextFieldTitle(title: "QUANTITY"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Enter quantity for category",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            pricing.price = double.parse(value);
                            widget.getFunction(pricings);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Quantity is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
