import 'package:api_call_sqlight_flu_bloc/view/home_screen.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../bloc/sql_bloc/profile_sqlight_bloc.dart';
import '../bloc/sql_bloc/profile_sqlight_event.dart';
import '../bloc/sql_bloc/profile_sqlight_state.dart';
import '../common_view/CommanButtonCricle.dart';
import '../common_view/CommonImage.dart';
import '../common_view/CommonImageSvg.dart';
import '../common_view/CustomDropdownField.dart';
import '../common_view/CustomSvgCheckbox.dart';
import '../common_view/CustomTextFormField.dart';
import '../model/User.dart';
import '../utils/AppLogger.dart';
import '../utils/SharedPrefHelper.dart';
import '../utils/showToast.dart';

@RoutePage()
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> dropdownItems = ['One', 'Two', 'Three', 'Four'];
  String? _selectedItem;
  final edtfirstName = TextEditingController();
  final edtlastName = TextEditingController();
  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileSqlightBloc, ProfileSqlightState>(
        listener: (context, state) {
          if (state is UserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User added successfully ${state.users.first.firstName}")));
            SharedPrefHelper.saveUser(
              username: state.users.first.firstName,
              email: state.users.first.email,
              password: state.users.first.password,

            );

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const HomeScreen(),
              ),
            );
            //context.pop();
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserLoadingState) {
            Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 3.0,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                CommonImage(
                  imagePath: 'assets/images/img_sign_up.png',
                  crop: true,
                  fit: BoxFit.cover,
                ),


                const SizedBox(height: 22),

                Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                      CustomDropdownField(
                        items: ["India", "USA", "UK"],
                        selectedItem: _selectedItem,
                        onChanged: (value) {
                          setState(() {
                            _selectedItem = value;
                          });
                        },
                        hint: "Select Salutation",
                        dropdownIcon: const Icon(Icons.expand_more, color: Colors.black),
                        borderColor: const Color(0xFFE5E5E5),
                        borderWidth: 1.0,
                        borderRadius: 5.0,
                        backgroundColor: Colors.white,
                        height: 48,
                        width: double.infinity,
                      ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("First Name", style: TextStyle(color: Color(0xFF000000), fontFamily: "Poppins", fontSize: 16)),

                                    SizedBox(height: 10),
                                    CustomTextFormField(
                                      hintText: "Fname",
                                      controller: edtfirstName,
                                      obscureText: false,
                                      keyboardType: TextInputType.visiblePassword,
                                      prefixIcon: null,
                                      borderRadius: 5,
                                      borderWidth: 1,
                                      outlineBorderColor: const Color(0xFFE5E5E5),
                                      height: 48,
                                      width: double.infinity,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Password cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),


                                  ]

                                ),
                              ),
                              SizedBox(width: 20),

                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Last Name", style: TextStyle(color: Color(0xFF000000), fontFamily: "Poppins", fontSize: 16)),
                                      SizedBox(height: 10),

                                      CustomTextFormField(
                                        hintText: "Lname",
                                        controller: edtlastName,
                                        obscureText: false,
                                        keyboardType: TextInputType.visiblePassword,
                                        prefixIcon: null,
                                        borderRadius: 5,
                                        borderWidth: 1,
                                        outlineBorderColor: const Color(0xFFE5E5E5),
                                        height: 48,
                                        width: double.infinity,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Password cannot be empty';
                                          }
                                          return null;
                                        },
                                      ),

                                    ]

                                ),
                              )


                            ],

                          ),

                          SizedBox(height: 20),

                          Text("Email", style: TextStyle(color: Color(0xFF000000), fontFamily: "Poppins", fontSize: 16)),

                          SizedBox(height: 10),

                          CustomTextFormField(
                            hintText: "Enter your email",
                            controller: edtEmail,
                            obscureText: false,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: null,
                            borderRadius: 5,
                            borderWidth: 1,
                            outlineBorderColor: const Color(0xFFE5E5E5),
                            height: 48,
                            width: double.infinity,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty';
                              }
                              return null;
                            },
                          ),


                          SizedBox(height: 20),

                          Text("Password", style: TextStyle(color: Color(0xFF000000), fontFamily: "Poppins", fontSize: 16)),

                          SizedBox(height: 10),

                          CustomTextFormField(
                            hintText: "Enter your password",
                            controller: edtPassword,
                            obscureText: false,
                            keyboardType: TextInputType.text,
                            prefixIcon: null,
                            borderRadius: 5,
                            borderWidth: 1,
                            outlineBorderColor: const Color(0xFFE5E5E5),
                            height: 48,
                            width: double.infinity,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20),


                          Row(
                            children: [
                              CustomSvgCheckbox(
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = newValue ?? false;
                                  });
                                },

                                checkedIconPath: 'assets/images/icon_checked_checkbox.svg',
                                uncheckedIconPath: 'assets/images/icon_unchecked_checkbox.svg',
                              ),

                              SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.black, fontSize: 16),
                                  children: [
                                    const TextSpan(text: 'I Accept ',style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                      text: 'T&C',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                        },
                                    ),
                                  ],
                                ),
                              ),






                            ],
                          ),
                          SizedBox(height: 32),

                          Center(
                            child: CommanButtonCricle(
                              width: 139,
                              height: 48,
                              shape: BoxShape.rectangle,
                              borderRadius: 26,
                              gradientColors: [Color(0XFF1593C6), Color(0XFF224382)],
                              gradientDirection: GradientDirection.horizontal,
                              child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16)),
                              onTap: () {
                                final user = User(
                                  firstName: edtfirstName.text,
                                  lastName: edtlastName.text,
                                  email: edtEmail.text,
                                  password: edtPassword.text,
                                  country: _selectedItem ?? "India"

                                );

                                BlocProvider.of<ProfileSqlightBloc>(context).add(AddUserEvent(user));
                              },
                            ),
                          ),

                          SizedBox(height: 32),

                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                CommonImageSvg(
                                  imagePath: 'assets/images/img_goole.svg',
                                  crop: false,
                                  onTap: () {
                                    print("SVG image tapped");
                                  },
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 9),
                                  child: CommonImageSvg(
                                    imagePath: 'assets/images/img_face_book.svg',
                                    crop: false,
                                    onTap: () {
                                      print("SVG image tapped");
                                    },
                                  ),
                                ),
                                CommonImageSvg(
                                  imagePath: 'assets/images/img_apple.svg',
                                  crop: false,
                                  onTap: () {
                                    print("SVG image tapped");
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 25),

                          Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'Log In',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed('Login');
                                    // Navigate or perform action
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                          SizedBox(height: 32),



                        ],
                      ),
                    )

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}
