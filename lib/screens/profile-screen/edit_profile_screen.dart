import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/pick_image_helper.dart';
import '../../helpers/snack_bar_widget.dart';
import '../../models/users.dart';
import '../../providers/image_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/edit_profile_widgets/profile_input_container.dart';
import '../../widgets/edit_profile_widgets/select_gender_widget.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/custom_loading_indicator.dart';
import '../../widgets/general_widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/EditProfileScreen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Users? user;
  bool isLoading = false;

  String imageUrl = "";
  File imageFile = File("");
  bool isUploading = false;

  var nameController = TextEditingController();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var bioController = TextEditingController();
  var numberController = TextEditingController();

  var nameNode = FocusNode();
  var usernameNode = FocusNode();
  var emailNode = FocusNode();
  var bioNode = FocusNode();
  var numberNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getAndSetUserData();
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    bioController.dispose();
    numberController.dispose();

    nameNode.dispose();
    usernameNode.dispose();
    emailNode.dispose();
    bioNode.dispose();
    numberNode.dispose();
  }

  List<String> gender = [
    "Male",
    "Female",
    "Prefer not to say",
  ];
  String userGender = "Male";

  DateTime dateOfBirth = DateTime.now();
  String dbString = DateTime.now().year.toString();

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var sizedBox = SizedBox(
      height: 1.h,
    );

    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: const CustomAppBar(title: "Edit profile"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileImage(
                        imageUrl:
                            FirebaseAuth.instance.currentUser?.photoURL ?? "",
                        radius: 70.0,
                        userId: "",
                        isAuthUser: true,
                      ),
                      sizedBox,
                      isUploading
                          ? CustomLoadingIndicator(
                              height: 10.h,
                              width: 30.w,
                            )
                          : TextButton(
                              onPressed: () => ShowFilePicker.showFilePicker(
                                context: context,
                                getFile: getProfileImage,
                              ),
                              child: Text(
                                "Edit profile picture",
                                style: bodyMedium?.copyWith(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                      sizedBox,
                      CustomTextField(
                        label: "Name",
                        controller: nameController,
                        focusNode: nameNode,
                      ),
                      CustomTextField(
                        label: "Username",
                        controller: usernameController,
                        focusNode: usernameNode,
                      ),
                      CustomTextField(
                        label: "Email",
                        controller: emailController,
                        focusNode: emailNode,
                        inputType: TextInputType.emailAddress,
                      ),
                      CustomTextField(
                        label: "Bio",
                        controller: bioController,
                        focusNode: bioNode,
                        maxLines: 5,
                        maxText: 300,
                      ),
                      CustomTextField(
                        label: "Number",
                        controller: numberController,
                        focusNode: numberNode,
                        inputType: TextInputType.number,
                      ),
                      ProfileInputContainer(
                        child: SelectGenderWidget(
                          gender: gender,
                          userGender: userGender,
                          getUserGender: getNewUserGender,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      InkWell(
                        onTap: () => showBirthdayPicker(),
                        child: ProfileInputContainer(
                          child: Text(dbString),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomButton(
                        function: () => updateUserData(),
                        title: "Save",
                        isLoading: isLoading,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getProfileImage(File newImage) async {
    setState(() {
      imageFile = newImage;
    });

    setState(() {
      isUploading = true;
    });

    var appImageProvider =
        Provider.of<AppImageProvider>(context, listen: false);

    await appImageProvider
        .uploadProfileImage(imageFile)
        .then((value) => CustomSnackBar.showCustomSnackBar(
              _scaffoldKey,
              "Image updated",
              color: Colors.green,
            ));

    setState(() {
      isUploading = false;
    });
  }

  void getNewUserGender(String newUserGender) {
    setState(() {
      userGender = newUserGender;
    });
  }

  void showBirthdayPicker() async {
    var db = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1, 1),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
        builder: (BuildContext context, child) {
          var of = Theme.of(context);
          var primaryColor = of.primaryColor;
          return Theme(
            data: ThemeData(
                colorScheme: ColorScheme.light(
              primary: primaryColor,
            )),
            child: child!,
          );
        });

    if (db != null) {
      setState(() {
        dbString = "${db.day}/${db.month}/${db.year}";
        dateOfBirth = db;
      });
    }
  }

  void getAndSetUserData() {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    user = arguments["user"] as Users;

    setState(() {
      nameController = TextEditingController(text: user?.name ?? "");
      usernameController = TextEditingController(text: user?.username ?? "");
      emailController = TextEditingController(text: user?.email ?? "");
      numberController = TextEditingController(text: user?.number ?? "");
      bioController = TextEditingController(text: user?.bio ?? "");

      imageUrl = user?.imageUrl ?? "";
      userGender = user?.gender ?? "";
      dbString = user?.dateOfBirth.split(" ")[0] ?? "";
    });
  }

  void updateUserData() async {
    setState(() {
      isLoading = true;
    });

    var userProvider = Provider.of<UsersProvider>(context, listen: false);

    await userProvider
        .updateUserDetails(
      Users(
        id: user?.id ?? "",
        bio: bioController.text.trim(),
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        number: numberController.text.trim(),
        gender: userGender,
        hosted: user?.hosted ?? [],
        videoUrl: user?.videoUrl ?? "",
        username: usernameController.text.trim(),
        imageUrl: imageUrl,
        password: user?.password ?? "",
        attended: user?.attended ?? [],
        followers: user?.followers ?? [],
        following: user?.following ?? [],
        highlights: user?.highlights ?? [],
        dateOfBirth: dbString,
      ),
    )
        .then((value) async {
      final userProvider = Provider.of<UsersProvider>(context, listen: false);
      await userProvider.getCurrentUser();
    }).catchError((e) {
      print(e);
    });

    setState(() {
      isLoading = false;
    });
  }
}
