import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../bloc/sql_bloc/profile_sqlight_bloc.dart';
import '../bloc/sql_bloc/profile_sqlight_event.dart';
import '../bloc/sql_bloc/profile_sqlight_state.dart';
import '../common_view/CommanButtonCricle.dart';
import '../common_view/CustomSvgCheckbox.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileSqlightBloc, ProfileSqlightState>(
        listener: (context, state) {
          if (state is UserSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User added successfully")),
            );
            context.goNamed('Home');
          } else if (state is UserErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is UserLoadingState) {
            Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 3.0,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/img_login.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email / Phone",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins_regular",
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 10),

                      SizedBox(
                        height: 48, // Set desired height
                        width: double.infinity, // or specific width like 300
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: "Poppins",
                              fontSize: 14,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E5E5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E5E5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!RegExp(
                              r'^[^@]+@[^@]+\.[^@]+',
                            ).hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins_regular",
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 10),
                      SizedBox(
                        height: 48, // Set desired height
                        width: double.infinity,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Enter your password",
                            hintStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E5E5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFE5E5E5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                          ),
                          controller: _passwordController,
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomSvgCheckbox(
                                value: isChecked,
                                onChanged: (newValue) {
                                  setState(() {
                                    isChecked = newValue ?? false;
                                  });
                                },

                                checkedIconPath:
                                    'assets/images/icon_checked_checkbox.svg',
                                uncheckedIconPath:
                                    'assets/images/icon_unchecked_checkbox.svg',
                              ),

                              SizedBox(width: 10),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'I Accept ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'T&C',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins_regular",
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<ProfileSqlightBloc>(context).add(
                                LoginEvent(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                            }
                          },

                          child: Container(
                            width: 139,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF1593C6), Color(0xFF224382)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins_medium",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/img_goole.svg'),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(
                              'assets/images/img_face_book.svg',
                            ),
                          ),

                          SvgPicture.asset('assets/images/img_apple.svg'),
                        ],
                      ),

                      SizedBox(height: 25),

                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontFamily: "Poppins_regular",
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: "Sign up",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "poppins_bold",
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.goNamed('Register');
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 100),
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
}
