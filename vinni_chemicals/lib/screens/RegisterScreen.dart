import 'dart:convert';
import 'package:flutter/material.dart';
import '../utils.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  Future<void> registerUser() async {
    if (name.text.isNotEmpty &&
        email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        cPassword.text.isNotEmpty &&
        phoneNumber.text.isNotEmpty) {
      if (phoneNumber.text.length != 10) {
        Utils.toastMessage("Please enter a correct mobile number");
      } else {
        if (!EmailValidator.validate(email.text)) {
          Utils.toastMessage("Please enter a correct email");
        } else {
          if (password.text.length < 6) {
            Utils.toastMessage("Password length must be greater than 5");
          } else {
            if (password.text == cPassword.text) {
              try {
                String uri =
                    "http://10.0.2.2/vinni_chemicals_api/user_register_data.php";
                var res = await http.post(Uri.parse(uri), body: {
                  "name": name.text,
                  "email": email.text,
                  "phone_number": phoneNumber.text,
                  "password": password.text,
                });

                var response = jsonDecode(res.body);
                if(response["email_already"] == "true"){
                  Utils.toastMessage("Email already registered");
                }
                else if(response["phone_already"] == "true"){
                  Utils.toastMessage("Phone number already registered");
                }
                else if (response["success"] == "true") {
                  Utils.toastMessage("Registered");
                } else {
                  Utils.toastMessage("Oops! Try again");
                }
              } catch (e) {
                // print(e);
                Utils.toastMessage(
                    "We are facing some issue. Try after some time");
              }
            } else {
              Utils.toastMessage("Password not matching");
            }
          }
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
              'Create Your\nAccount',
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
                      margin: const EdgeInsets.only(top: 10.0),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: name,
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                            hintText: "Enter your name",
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
                              Icons.person,
                              color: Color(0xff11998e),
                            ),
                            label: const Text(
                              'Full Name',
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
                      margin: const EdgeInsets.only(top: 20.0),
                      child: TextFormField(
                        controller: phoneNumber,
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          fontSize: 15,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Enter your phone number",
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
                              Icons.phone,
                              color: Color(0xff11998e),
                            ),
                            label: const Text(
                              'Phone',
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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: TextFormField(
                        controller: cPassword,
                        style: const TextStyle(
                          fontFamily: 'MontserratLight',
                          fontSize: 15,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Confirm your password",
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
                              'Conform Password',
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
                        registerUser();
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
                            'SIGN UP',
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
                            "Already have account?",
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
                                      builder: (context) => LoginScreen()));
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
