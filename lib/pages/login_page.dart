// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:notebook/pages/homePage.dart';
import 'package:notebook/pages/registration.dart';
import 'package:notebook/provider/user_provider.dart';
import 'package:notebook/pages/util/custom_button.dart';
import 'package:notebook/pages/util/memory-management.dart';
import 'package:notebook/pages/util/util.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController? userNameTextCtl;
  TextEditingController? passwordTextCtl;
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();
    userNameTextCtl = TextEditingController();
    passwordTextCtl = TextEditingController();
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
                      text: "LogIn",
                      onPressed: () async {
                        if (formKey!.currentState!.validate()) {
                          await provider.fetchUser(
                              userNameTextCtl!.text, passwordTextCtl!.text);
                          if (provider.getUser().username == null) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "username or password are nor exist")));
                          } else {
                            MemoryManagement.setLoggedIn(true);
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) {
                              return HomePage();
                            }), (route) => false);
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const RegisterPage();
                          }));
                        },
                        child: const Padding(
                          padding:
                              EdgeInsets.only(bottom: 25, left: 5, right: 5),
                          child: Text("New To App? Register Now"),
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
