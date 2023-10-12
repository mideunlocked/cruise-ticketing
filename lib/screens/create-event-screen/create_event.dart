import 'dart:io';

import 'package:cruise/models/event.dart';
import 'package:cruise/models/event_analysis.dart';
import 'package:cruise/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/pricing.dart';
import '../../widgets/create_event_widgets/step_control.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import 'step1.dart';
import 'step2.dart';
import 'step3.dart';
import 'step4.dart';
import 'step5.dart';
import 'step6.dart';

class CreateEventScreen extends StatefulWidget {
  static const routeName = "/CreateEventScreen";

  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _ListEventState();
}

class _ListEventState extends State<CreateEventScreen> {
  // current index of the steper
  int currentStep = 0;

  // all the controllers used in the screen
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final rulesController = TextEditingController();

  // all the focus node used in the screen
  final nameNode = FocusNode();
  final descriptionNode = FocusNode();
  final rulesNode = FocusNode();

  // this will hold the list of pricings
  List<Pricing> pricing = [];

  // this will hold the image path
  File bannerFile = File('');

  // this will hold the features of the event
  List<dynamic> features = [];

  // this will hold the date and time of the event
  List<Map<String, dynamic>> dateTime = [];

  // this will hold privacy status
  bool privacy = false;

  @override
  void dispose() {
    super.dispose();

    // dispose all controllers
    nameController.dispose();
    descriptionController.dispose();
    rulesController.dispose();

    // dispose all focus nodes
    nameNode.dispose();
    descriptionNode.dispose();
    rulesNode.dispose();
  }

  final _step5FormKey = GlobalKey<FormState>();
  final _step1FormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    // required themes within the app for ui
    var of = Theme.of(context);
    var primaryColor = of.primaryColor;
    var scaffoldBackgroundColor = of.scaffoldBackgroundColor;

    // checks if device is light mode or dark mode
    // bool checkMode =
    //     MediaQuery.platformBrightnessOf(context) == Brightness.light;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    );

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // app bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: const CustomAppBar(
                  title: "Create Event",
                  bottomPadding: 0,
                ),
              ),

              // stepper body
              Expanded(
                // in other to be able to design the stepper to fit app design
                //it has to be passed as a child to a newly declared theme
                //widget where we can then change all the necessary themes
                child: Theme(
                  data: ThemeData(
                    primaryColor: primaryColor,
                    canvasColor: scaffoldBackgroundColor,
                    textTheme: of.textTheme.copyWith(
                      titleMedium: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    colorScheme: ColorScheme.light(
                      primary: primaryColor,
                      onSurface: Colors.black12,
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: Colors.black12,
                      border: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      hintStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 8.sp,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  child: Stepper(
                    currentStep: currentStep,
                    steps: [
                      // first step (basic info)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 0,
                        content: Step1(
                          nameController: nameController,
                          descriptionController: descriptionController,
                          nameNode: nameNode,
                          descriptionNode: descriptionNode,
                          currentStep: currentStep,
                          formKey: _step1FormKey,
                        ),
                      ),

                      // Second step (Event Image/Banner)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 1,
                        content: Step2(
                          getFunction: getImage,
                        ),
                      ),

                      // third step (Event details)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 2,
                        content: Step3(
                          rulesController: rulesController,
                          rulesNode: rulesNode,
                          getFunction: getFeatures,
                        ),
                      ),

                      // fourth step (Event date and time)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 3,
                        content: Step4(
                          getFunction: getDateTime,
                        ),
                      ),

                      // fifth step (Ticket pricings)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 4,
                        content: Step5(
                          // pricings: pricing,
                          formKey: _step5FormKey,
                          getFunction: getPricings,
                        ),
                      ),

                      // sixth step (event privacy and visibilty)
                      Step(
                        title: const Text(""),
                        isActive: currentStep >= 5,
                        content: Step6(
                          getFunction: getPrivacy,
                        ),
                      ),
                    ],
                    elevation: 0,
                    type: StepperType.horizontal,

                    // custom control builder and widget
                    controlsBuilder: (context, details) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // check is the current step is the first step
                          currentStep == 0
                              ?
                              // then displays an empty widget
                              const SizedBox()
                              :
                              // else display the back button
                              StepControl(
                                  title: "Back",
                                  function: () {
                                    currentStep != 0
                                        ? setState(() => currentStep--)
                                        : null;
                                  },
                                ),

                          // proceed button
                          StepControl(
                            // check if the current step if the last then
                            //displays finish else next
                            title: currentStep == 5 ? "Finish" : "Next",
                            function: () {
                              // function variable to proceed step
                              proceed() => setState(() => currentStep++);

                              // check is function is called from first step
                              if (currentStep == 0) {
                                // validate ticket pricing text form fields
                                final isValid =
                                    _step1FormKey.currentState?.validate();

                                // check if the validation was not successful
                                if (isValid == false) {
                                  // throw errors
                                  return;
                                }
                                // else is successful so proceed else {
                                // else proceed the stepper
                                proceed();
                              }

                              // check is function is called from second step
                              else if (currentStep == 1) {
                                // check if a image file as been passed
                                if (bannerFile.existsSync() == false) {
                                  // show snack bar if no image file as been passed
                                  showSnackBar(
                                    scaffoldKey: _scaffoldKey,
                                    errorMessage:
                                        "Event image/banner is required",
                                  );
                                }
                                // else proceed to next step
                                else {
                                  print(bannerFile.path.toString());
                                  proceed();
                                }
                              }
                              // check is function is called from third step
                              else if (currentStep == 2) {
                                // check is rules controller is empty
                                if (rulesController.text.isEmpty) {
                                  // show snack bar if is empty
                                  showSnackBar(scaffoldKey: _scaffoldKey);
                                }
                                // check if any feature as been selected
                                else if (features.isEmpty) {
                                  // show snack bar if no feature as been selected
                                  showSnackBar(
                                      scaffoldKey: _scaffoldKey,
                                      errorMessage:
                                          'Please choose an event feature.');
                                }
                                // else proceed to next step
                                else {
                                  print(features);
                                  proceed();
                                }
                              } else if (currentStep == 3) {
                                if (dateTime.length != 2) {
                                  print(dateTime);
                                  showSnackBar(
                                    scaffoldKey: _scaffoldKey,
                                    errorMessage: "Select date and time",
                                  );
                                } else {
                                  print(dateTime);
                                  proceed();
                                }
                              }
                              // check is function is called from fourth step
                              else if (currentStep == 4) {
                                // validate ticket pricing text form fields
                                final isValid =
                                    _step5FormKey.currentState?.validate();

                                // check if the validation was not successful
                                if (isValid == false) {
                                  // throw errors
                                  return;
                                }
                                // else is successful so proceed
                                else {
                                  calculateTotalQuantity();
                                  proceed();
                                }
                              }
                              // else proceed
                              else {
                                createEvent();
                                // print(privacy);
                                // Navigator.pushNamedAndRemoveUntil(
                                //   context,
                                //   "/EventCreateSuccessScreen",
                                //   (route) => false,
                                // );
                              }
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

  void getDateTime(List<Map<String, dynamic>> newDateTime) {
    setState(() {
      dateTime = newDateTime;
    });
  }

  void getImage(File imageFile) {
    setState(() {
      bannerFile = imageFile;
    });
  }

  void getFeatures(List<dynamic> newFeatures) {
    setState(() {
      features = newFeatures;
    });
  }

  void getPricings(List<Pricing> newPricing) {
    setState(() {
      pricing = newPricing;
    });
  }

  void getPrivacy(bool isPublic) {
    setState(() {
      privacy = isPublic;
    });
  }

  // show custom snack bar widget method
  void showSnackBar({
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    String errorMessage = "All fields are required",
  }) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SizedBox(
          width: 80,
          child: Text(errorMessage),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  int calculateTotalQuantity() {
    int quantity = 0;

    for (var e in pricing) {
      quantity = quantity + e.quantity;
    }

    return quantity;
  }

  // create event
  void createEvent() {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    int demoId = eventProvider.events.length + 1;

    final response = eventProvider.addEvent(
      Event(
        id: demoId.toString(),
        name: nameController.text.trim(),
        date: dateTime[0]["date"] as DateTime,
        time: dateTime[1]["time"] as TimeOfDay,
        venue: "Whiteley Event Center",
        rules: rulesController.text.trim(),
        hostId: "12345",
        latlng: {
          "lat": 6.499952,
          "lng": 3.346991,
        },
        isValid: true,
        rating: 4.0,
        pricing: pricing,
        imageUrl: bannerFile.path,
        videoUrl: "",
        features: features,
        attendees: [],
        isPrivate: privacy,
        timestamp: DateTime.now(),
        description: descriptionController.text.trim(),
        ticketQuantity: calculateTotalQuantity(),
        analysis: EventAnalysis(
          ages: [],
          genders: [],
          ticketSold: 0,
          totalViews: 0,
          attendance: 0,
          deviceSales: [],
          ticketQuantity: calculateTotalQuantity(),
          attendeeLocations: [],
          soldTicketBreakdown: [],
        ),
      ),
    );

    response == true
        ? print("Event created")
        : showSnackBar(
            scaffoldKey: _scaffoldKey,
            errorMessage:
                "Something went wrong can't create event, Try again later.",
          );
  }
}
