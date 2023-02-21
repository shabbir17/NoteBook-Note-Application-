// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/models/user.dart';
import 'package:notebook/pages/homePage.dart';
import 'package:notebook/provider/user_provider.dart';
import 'package:notebook/pages/util/custom_button.dart';
import 'package:notebook/pages/util/util.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? userNameTextCtl;
  TextEditingController? passwordTextCtl;
  TextEditingController? firstNameTextCtl;
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();
    userNameTextCtl = TextEditingController();
    passwordTextCtl = TextEditingController();
    firstNameTextCtl = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (_, provider, ___) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 38, right: 38),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //Username
                    Container(
                      height: 55,
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        controller: firstNameTextCtl,
                        enabled: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Provide FirstName";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter First Name",
                          contentPadding: EdgeInsets.only(
                              left: 11, right: 3, top: 14, bottom: 14),
                          errorStyle: TextStyle(fontSize: 11, height: 0.2),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 4, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        controller: userNameTextCtl,
                        enabled: true,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              Util.isEmailFormatNotValid(value) == true) {
                            return "Please Provide UserName";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter user Name",
                          contentPadding: EdgeInsets.only(
                              left: 11, right: 3, top: 14, bottom: 14),
                          errorStyle: TextStyle(fontSize: 11, height: 0.2),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 4, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    //password
                    Container(
                      height: 55,
                      alignment: Alignment.centerLeft,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: passwordTextCtl,
                        enabled: true,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 4) {
                            return "Password must be 5 digit long";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter password",
                          contentPadding: EdgeInsets.only(
                              left: 11, right: 3, top: 14, bottom: 14),
                          errorStyle: TextStyle(fontSize: 11, height: 0.2),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 4, color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 5, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    CustomButton(
                      text: "REGISTER",
                      onPressed: () async {
                        if (formKey!.currentState!.validate()) {
                          User user = User(
                              name: firstNameTextCtl!.text,
                              username: userNameTextCtl!.text,
                              password: passwordTextCtl!.text);

                          String status = await provider.isUserExist(user);
                          if (status != "Success") {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("username already exist")));
                          } else {
                            Navigator.pop(context);
                          }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.only(bottom: 25, left: 5, right: 5),
                          child: Text("Already registered, LogIN Now"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
