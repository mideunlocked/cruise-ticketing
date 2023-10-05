import 'package:cruise/widgets/general_widgets/custom_app_bar.dart';
import 'package:cruise/widgets/general_widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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

class ProfileInputContainer extends StatelessWidget {
  const ProfileInputContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.5.h,
      width: 100.w,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      margin: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

// ignore: must_be_immutable
class SelectGenderWidget extends StatefulWidget {
  SelectGenderWidget({
    super.key,
    required this.gender,
    required this.userGender,
  });

  late String userGender;
  final List<String> gender;

  @override
  State<SelectGenderWidget> createState() => _SelectGenderWidgetState();
}

class _SelectGenderWidgetState extends State<SelectGenderWidget> {
  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var bodyMedium = textTheme.bodyMedium;

    return DropdownButton(
      value: widget.userGender,
      isExpanded: true,
      borderRadius: BorderRadius.circular(20),
      style: bodyMedium,
      underline: const SizedBox(),
      menuMaxHeight: 75.h,
      items: widget.gender
          .map(
            (gender) => DropdownMenuItem(
              value: gender,
              child: Text(gender),
            ),
          )
          .toList(),
      onChanged: (value) {
        setState(() {
          widget.userGender = value!.trim().toString();
        });
      },
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    this.inputType = TextInputType.name,
    this.inputAction = TextInputAction.next,
    this.maxLines,
    this.maxText,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int? maxLines;
  final int? maxText;

  @override
  Widget build(BuildContext context) {
    var of = Theme.of(context);
    var textTheme = of.textTheme;
    var primaryColor = of.primaryColor;
    var bodyMedium = textTheme.bodyMedium;

    var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        color: Colors.black,
      ),
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
      ),
      child: TextFormField(
        style: bodyMedium,
        cursorColor: primaryColor,
        textInputAction: inputAction,
        keyboardType: inputType,
        maxLength: maxText,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: outlineInputBorder,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          labelStyle: bodyMedium?.copyWith(
            fontSize: 12.sp,
          ),
          hintStyle: bodyMedium?.copyWith(
            color: Colors.black26,
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "This field can't be empty";
          }
          return null;
        },
      ),
    );
  }
}
