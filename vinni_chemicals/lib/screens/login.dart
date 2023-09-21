import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinni_chemicals/screens/RegisterScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:vinni_chemicals/screens/home_screen.dart';
import 'package:vinni_chemicals/screens/main_page.dart';
import 'package:vinni_chemicals/utils.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      if (!EmailValidator.validate(email.text)) {
        Utils.toastMessage("Please enter a correct email");
      } else {
        try {
          String uri =
              "http://10.0.2.2/vinni_chemicals_api/login_user.php";
          var res = await http.post(Uri.parse(uri), body: {
            "email": email.text,
            "password": password.text,
          });

          var response = jsonDecode(res.body);
          if (response["login_success"] == "true" && response["is_verified"] == "true") {
            var uid = response["uid"].toString();
            final prefs = await SharedPreferences.getInstance();
            prefs.setBool("isLoggedIn", true);
            prefs.setString("uid", uid.toString());
            print(uid.toString());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage()));
          }
          else if (response["login_success"] == "false" && response["is_verified"] == "false") {
            Utils.toastMessage("Please wait your account will be verified within 24 hours!");
          }
          else if (response["login_success"] == "false" && response["no_user"] == "true") {
            Utils.toastMessage("User not found");
          } else {
            Utils.toastMessage("Oops! Try again later");
          }
        } catch (e) {
          // print(e);
          Utils.toastMessage("We are facing some issue. Try after some time");
        }
      }
    } else {
      Utils.toastMessage("Fill all fields!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff11998e),
                  Color(0xff38ef7d),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Login \nto Continue',
                  style: TextStyle(
                      fontSize: 30, color: Colors.white, fontFamily: 'Montserrat'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 18.0, right: 18, top: 20.0, bottom: 10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: email,
                            style: const TextStyle(
                              fontFamily: 'MontserratLight',
                              fontSize: 15,
                            ),
                            // keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff11998e),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff38ef7d),
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'MontserratLight',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                prefixIcon: const Icon(
                                  Icons.mail,
                                  color: Color(0xff11998e),
                                ),
                                label: const Text(
                                  'Gmail',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff11998e),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: password,
                            style: const TextStyle(
                              fontFamily: 'MontserratLight',
                              fontSize: 15,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Enter your password",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff11998e),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff38ef7d),
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'MontserratLight',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                prefixIcon: const Icon(
                                  Icons.key,
                                  color: Color(0xff11998e),
                                ),
                                label: const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff11998e),
                                  ),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            loginUser(context);
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0xff11998e),
                                Color(0xff38ef7d),
                              ]),
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'MontserratLight',
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account?",
                                style: TextStyle(
                                    fontFamily: 'MontserratLight',
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    // Done login page
                                      fontFamily: 'MontserratLight',
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RegisterScreen()));
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
