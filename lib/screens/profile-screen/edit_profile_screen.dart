import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/date_time_formatting.dart';
import '../../models/users.dart';
import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/edit_profile_widgets/profile_input_container.dart';
import '../../widgets/edit_profile_widgets/select_gender_widget.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/custom_button.dart';
import '../../widgets/general_widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/EditProfileScreen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String imageUrl = "";
  String name = "";

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

  String dateOfBirth = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    var sizedBox = SizedBox(
      height: 1.h,
    );

    getAndSetUserData();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              CustomAppBar(
                title: "Edit profile",
                bottomPadding: 2.h,
              ),
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
                      TextButton(
                        onPressed: () {},
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
                          child: Text(dateOfBirth),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomButton(
                        function: () {},
                        title: "Save",
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
        dateOfBirth = "${db.day}/${db.month}/${db.year}";
      });
    }
  }

  void getAndSetUserData() {
    var arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    Users user = arguments["user"] as Users;

    setState(() {
      nameController = TextEditingController(text: user.name);
      usernameController = TextEditingController(text: user.username);
      emailController = TextEditingController(text: user.email);
      numberController = TextEditingController(text: user.number);
      bioController = TextEditingController(text: user.bio);

      imageUrl = user.imageUrl;
      userGender = user.gender;
      dateOfBirth = DateTimeFormatting.formatDateTime(user.dateOfBirth);
    });
  }
}
