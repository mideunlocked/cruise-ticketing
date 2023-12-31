import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../helpers/location_helper.dart';
import '../helpers/snack_bar_widget.dart';
import '../models/event.dart';
import '../models/event_analysis.dart';
import '../models/pricing.dart';
import '../providers/event_provider.dart';
import '../widgets/create_event_widgets/step_control.dart';
import '../widgets/general_widgets/custom_app_bar.dart';
import '../pages/create-event/step1.dart';
import '../pages/create-event/step2.dart';
import '../pages/create-event/step3.dart';
import '../pages/create-event/step4.dart';
import '../pages/create-event/step5.dart';
import '../pages/create-event/step6.dart';
import '../pages/create-event/step7.dart';
import '../widgets/general_widgets/indisimissible_loading_indicator.dart';

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
  final venueController = TextEditingController();
  final addressController = TextEditingController();

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
  Map<String, dynamic> dateTime = {};

  // this will hold privacy status
  bool privacy = false;

  @override
  void dispose() {
    super.dispose();

    // dispose all controllers
    nameController.dispose();
    descriptionController.dispose();
    rulesController.dispose();
    venueController.dispose();
    addressController.dispose();

    // dispose all focus nodes
    nameNode.dispose();
    descriptionNode.dispose();
    rulesNode.dispose();
  }

  final _step5FormKey = GlobalKey<FormState>();
  final _step6FormKey = GlobalKey<FormState>();
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
        appBar: const CustomAppBar(title: "Create event"),
        body: Theme(
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
                  venueController: venueController,
                  addressController: addressController,
                  formKey: _step6FormKey,
                ),
              ),

              // 7 step (event privacy and visibilty)
              Step(
                title: const Text(""),
                isActive: currentStep >= 6,
                content: Step7(
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
                    title: currentStep == 6 ? "Finish" : "Next",
                    function: () {
                      // function variable to proceed step
                      proceed() => setState(() => currentStep++);

                      // check is function is called from first step
                      if (currentStep == 0) {
                        // validate ticket pricing text form fields
                        final isValid = _step1FormKey.currentState?.validate();

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
                          CustomSnackBar.showCustomSnackBar(
                            _scaffoldKey,
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
                          CustomSnackBar.showCustomSnackBar(
                            _scaffoldKey,
                            "All fields are required",
                          );
                        }
                        // check if any feature as been selected
                        else if (features.isEmpty) {
                          // show snack bar if no feature as been selected
                          CustomSnackBar.showCustomSnackBar(
                              _scaffoldKey, 'Please choose an event feature.');
                        }
                        // else proceed to next step
                        else {
                          print(features);
                          proceed();
                        }
                      } else if (currentStep == 3) {
                        if (dateTime.length != 3) {
                          print(dateTime);
                          CustomSnackBar.showCustomSnackBar(
                            _scaffoldKey,
                            "Select date and time",
                          );
                        } else {
                          print(dateTime);
                          proceed();
                        }
                      }
                      // check is function is called from fourth step
                      else if (currentStep == 4) {
                        // validate ticket pricing text form fields
                        final isValid = _step5FormKey.currentState?.validate();

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
                      } else if (currentStep == 5) {
                        // validate venue and address text form fields
                        final isValid = _step6FormKey.currentState?.validate();

                        // check if the validation was not successful
                        if (isValid == false) {
                          // throw errors
                          return;
                        } else {
                          proceed();
                        }
                      }
                      // else proceed
                      else {
                        showLoadingIndicator();
                        createEvent();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getDateTime(Map<String, dynamic> newDateTime) {
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

  int calculateTotalQuantity() {
    int quantity = 0;

    for (var e in pricing) {
      quantity = quantity + e.quantity;
    }

    return quantity;
  }

  // create event
  void createEvent() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    LatLng latlng = await LocationHelper.getLatLngFromAddress(
        addressController.text.trim());

    Event event = Event(
      id: "",
      name: nameController.text.trim(),
      date: dateTime["date"] as DateTime,
      startTime: dateTime["start"] as TimeOfDay,
      endTime: dateTime["end"] as TimeOfDay,
      venue: venueController.text.trim(),
      address: addressController.text.trim(),
      rules: rulesController.text.trim(),
      hostId: eventProvider.authInstance.currentUser?.uid ?? "",
      geoPoint: GeoPoint(
        latlng.latitude,
        latlng.longitude,
      ),
      isValid: true,
      rating: 0,
      pricing: pricing,
      imageUrl: bannerFile.path,
      videoUrl: "",
      features: features,
      attendees: [],
      reviews: [],
      isPrivate: privacy,
      timestamp: Timestamp.now(),
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
        soldTicketBreakdown: pricing
            .map((e) => {
                  "id": e.id,
                  "value": 0,
                  "type": e.category,
                })
            .toList(),
      ),
      saved: [],
    );

    final response = await eventProvider.addEvent(
      event,
    );

    if (response == true) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/EventCreateSuccessScreen",
          (route) => false,
          arguments: event,
        );
      }
    } else {
      if (mounted) {
        Navigator.pop(context);
      }
      CustomSnackBar.showCustomSnackBar(
        _scaffoldKey,
        "Something went wrong can't create event, Try again later.",
      );
    }
  }

  void showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const UndismissbleLoadingIndicator(),
    );
  }
}
