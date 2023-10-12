import 'package:cruise/widgets/general_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/edit_profile_widgets/custom_text_field.dart';
import '../../widgets/edit_profile_widgets/profile_input_container.dart';
import '../../widgets/edit_profile_widgets/select_gender_widget.dart';
import '../../widgets/general_widgets/custom_app_bar.dart';
import '../../widgets/general_widgets/profile_image.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/EditProfileScreen";

  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  final numberController = TextEditingController();

  final nameNode = FocusNode();
  final usernameNode = FocusNode();
  final emailNode = FocusNode();
  final bioNode = FocusNode();
  final numberNode = FocusNode();

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
                      const ProfileImage(
                        imageUrl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTApbxj4499GJJWMYvKUVnzMUBJBt1b_Aob0A&usqp=CAU",
                        radius: 70.0,
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
                        ),
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

  void showBirthdayPicker() async {
    final db = await showDatePicker(
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
}
