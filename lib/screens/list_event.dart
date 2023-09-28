import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../data.dart';
import '../models/ticket_type.dart';
import '../widgets/event_screen_widgets/event_screen_title_widget.dart';
import '../widgets/event_screen_widgets/features_tile_widget.dart';
import '../widgets/general_widgets/custom_app_bar.dart';

class ListEventScreen extends StatefulWidget {
  static const routeName = "/ListEventScreen";

  const ListEventScreen({super.key});

  @override
  State<ListEventScreen> createState() => _ListEventState();
}

class _ListEventState extends State<ListEventScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final rulesController = TextEditingController();

  final nameNode = FocusNode();
  final descriptionNode = FocusNode();
  final rulesNode = FocusNode();

  List<Pricing> pricing = [];

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    descriptionController.dispose();
    rulesController.dispose();

    nameNode.dispose();
    descriptionNode.dispose();
    rulesNode.dispose();
  }

  int currentStep = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: const CustomAppBar(
                  title: "Create Event",
                  bottomPadding: 0,
                ),
              ),
              Expanded(
                child: Theme(
                  data: ThemeData(
                    primaryColor: primaryColor,
                    canvasColor: scaffoldBackgroundColor,
                    textTheme: of.textTheme.copyWith(
                      titleMedium: TextStyle(
                        color: checkMode ? Colors.black : Colors.white,
                      ),
                    ),
                    colorScheme: ColorScheme.light(
                      primary: primaryColor,
                      onSurface: checkMode ? Colors.black12 : Colors.white10,
                    ),
                    inputDecorationTheme: of.inputDecorationTheme,
                  ),
                  child: Stepper(
                    currentStep: currentStep,
                    steps: [
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 0,
                        content: Step1(
                          nameController: nameController,
                          descriptionController: descriptionController,
                          nameNode: nameNode,
                          descriptionNode: descriptionNode,
                          currentStep: currentStep,
                        ),
                      ),
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 1,
                        content: const Step2(),
                      ),
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 2,
                        content: Step3(
                          rulesController: rulesController,
                          rulesNode: rulesNode,
                        ),
                      ),
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 3,
                        content: Step4(
                          pricings: pricing,
                        ),
                      ),
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 4,
                        content: const Step5(),
                      ),
                    ],
                    elevation: 0,
                    type: StepperType.horizontal,
                    controlsBuilder: (context, details) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentStep == 0
                              ? const SizedBox()
                              : StepControlBuilder(
                                  title: "Back",
                                  function: () {
                                    currentStep != 0
                                        ? setState(() => currentStep--)
                                        : null;
                                  },
                                ),
                          StepControlBuilder(
                            title: currentStep == 4 ? "Finish" : "Next",
                            function: () {
                              // final isValid = _formKey.currentState!.validate();
                              // if (isValid == false) {
                              //   return;
                              // } else {
                              currentStep < 4
                                  ? setState(() => currentStep++)
                                  : null;
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Step5 extends StatefulWidget {
  const Step5({
    super.key,
  });

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> {
  bool isPublic = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Privacy and visibility"),
        SizedBox(
          height: 5.h,
        ),
        Row(
          children: [
            SizedBox(
              width: 70.w,
              child: const Text(
                  "Is the event intended for public access, open to everyone?"),
            ),
            Switch(
              value: isPublic,
              onChanged: (value) {
                setState(() {
                  isPublic = value;
                });
                print(isPublic);
              },
              inactiveTrackColor: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

class Step4 extends StatefulWidget {
  const Step4({
    super.key,
    required this.pricings,
  });

  final List<Pricing> pricings;

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  bool isFree = true;
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Ticket pricing"),
        SizedBox(
          height: 5.h,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.pricings.length + 1,
            itemBuilder: (ctx, index) {
              if (index == widget.pricings.length) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.pricings.add(
                        Pricing(
                          category: '',
                          price: 0.0,
                          quantity: 0,
                        ),
                      );
                    });
                  },
                  child: const Text('Add Ticket'),
                );
              }
              final pricing = widget.pricings[index];
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
                            widget.pricings.removeAt(index);
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
                        });
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
                        });
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
                        });
                      },
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }
}

class Step3 extends StatefulWidget {
  const Step3({
    super.key,
    required this.rulesController,
    required this.rulesNode,
  });

  final TextEditingController rulesController;
  final FocusNode rulesNode;

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  List<dynamic> pickedFeatures = [];

  var feature = eventFeatures[0];

  @override
  Widget build(BuildContext context) {
    eventFeatures.sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Event Details"),
        SizedBox(
          height: 5.h,
        ),
        CustomAddEventTextField(
          controller: widget.rulesController,
          node: widget.rulesNode,
          hint: "Set rules",
          title: "RULES",
          maxLines: 10,
        ),
        const TextFieldTitle(title: "FEATURES"),
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.w,
            mainAxisSpacing: 4.w,
            mainAxisExtent: 5.h,
          ),
          children: eventFeatures
              .map(
                (e) => InkWell(
                  onTap: () {
                    setState(() {
                      if (pickedFeatures.contains(e)) {
                        pickedFeatures.remove(e);
                      } else {
                        pickedFeatures.add(e);
                      }
                    });
                    print(pickedFeatures);
                  },
                  child: FeaturesTileWidget(
                    title: e,
                    isPicked: pickedFeatures.contains(e),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class Step2 extends StatefulWidget {
  const Step2({
    super.key,
  });

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  File eventImage = File("");

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    Color color = checkMode ? Colors.black26 : Colors.white54;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Event Image/Banner"),
        SizedBox(
          height: 5.h,
        ),
        const TextFieldTitle(title: "Image/Banner"),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            eventImage,
            height: 50.h,
            width: 100.w,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        InkWell(
          onTap: () => pickImage(),
          child: Container(
            height: 7.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_upload_outlined,
                  color: color,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  "Upload image",
                  style: of.textTheme.bodyMedium?.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedImage == null) {
      return;
    }

    setState(() {
      eventImage = File(pickedImage.path);
    });
    print(eventImage.path);
  }
}

class StepControlBuilder extends StatelessWidget {
  const StepControlBuilder({
    super.key,
    required this.title,
    required this.function,
  });

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;

    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          primaryColor.withOpacity(0.2),
        ),
      ),
      onPressed: () {
        function();
      },
      child: Text(
        title,
        style: of.textTheme.bodyMedium?.copyWith(color: primaryColor),
      ),
    );
  }
}

class Step1 extends StatefulWidget {
  const Step1({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.descriptionNode,
    required this.nameNode,
    required this.currentStep,
  });

  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final FocusNode descriptionNode;
  final FocusNode nameNode;
  final int currentStep;

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventScreenTitleWidget(title: "Basic Info"),
        SizedBox(
          height: 5.h,
        ),
        CustomAddEventTextField(
          controller: widget.nameController,
          node: widget.nameNode,
          title: "TITLE",
          hint: "Enter event title",
          maxLenght: 25,
        ),
        CustomAddEventTextField(
          controller: widget.descriptionController,
          node: widget.descriptionNode,
          title: "DESCRIPTION",
          hint: "Enter event description",
          maxLines: 10,
        ),
        const SelectGenerWidget(),
      ],
    );
  }
}

class SelectGenerWidget extends StatefulWidget {
  const SelectGenerWidget({
    super.key,
  });

  @override
  State<SelectGenerWidget> createState() => _SelectGenerWidgetState();
}

class _SelectGenerWidgetState extends State<SelectGenerWidget> {
  String gener = eventCategoryNames[0];

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextFieldTitle(
          title: "GENER",
        ),
        Container(
          height: 7.h,
          decoration: BoxDecoration(
            color: of.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: DropdownButton(
            value: gener,
            isExpanded: true,
            borderRadius: BorderRadius.circular(20),
            hint: Text(
              "Choose the Gener of Event",
              style: bodyMedium?.copyWith(
                color: checkMode ? Colors.black26 : Colors.white54,
              ),
            ),
            style: bodyMedium,
            underline: const SizedBox(),
            menuMaxHeight: 75.h,
            items: eventCategoryNames
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                gener = value!.trim().toString();
              });
            },
          ),
        ),
      ],
    );
  }
}

class CustomAddEventTextField extends StatelessWidget {
  const CustomAddEventTextField({
    super.key,
    required this.controller,
    required this.node,
    required this.hint,
    required this.title,
    this.maxLines = 1,
    this.maxLenght,
  });

  final TextEditingController controller;
  final FocusNode node;
  final String hint;
  final String title;
  final int? maxLenght;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;
    var primaryColor = of.primaryColor;

    bool checkMode =
        MediaQuery.platformBrightnessOf(context) == Brightness.light;

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldTitle(
            title: title,
          ),
          TextFormField(
            controller: controller,
            focusNode: node,
            maxLength: maxLenght,
            maxLines: maxLines,
            style: bodyMedium,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                maxLenght == null
                    ? const SizedBox()
                    : Text(
                        "$currentLength/$maxLength",
                        style: bodyMedium?.copyWith(
                            fontSize: 8.sp,
                            color: isFocused
                                ? null
                                : checkMode
                                    ? Colors.black54
                                    : Colors.white54),
                      ),
            decoration: InputDecoration(
              hintText: hint,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "This field can't be empty";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class TextFieldTitle extends StatelessWidget {
  const TextFieldTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text(
        title,
        style: const TextStyle(letterSpacing: 1.0),
      ),
    );
  }
}
