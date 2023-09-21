import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils.dart';
import 'login.dart';

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
      try {
        String uri =
            "http://10.0.2.2/dynamic_ft_api/register_user.php";
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
        Utils.toastMessage("We are facing some issue.\nTry again later");
        // print("outside");
        // print(e.toString());
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
                  Color(0xff2193b0),
                  Color(0xff6dd5ed),
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
                            decoration: InputDecoration(
                                hintText: "Enter your name",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff2193b0),
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
                                  color: Color(0xff2193b0),
                                ),
                                label: const Text(
                                  'Full Name',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2193b0),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: TextFormField(
                            controller: phoneNumber,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                hintText: "Enter your phone number",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff2193b0),
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
                                  color: Color(0xff2193b0),
                                ),
                                label: const Text(
                                  'Phone',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2193b0),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: email,
                            // keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                hintText: "Enter your email",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff2193b0),
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
                                  color: Color(0xff2193b0),
                                ),
                                label: const Text(
                                  'Gmail',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2193b0),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Enter your password",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff2193b0),
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
                                  color: Color(0xff2193b0),
                                ),
                                label: const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2193b0),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                            controller: cPassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                hintText: "Confirm your password",
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Color(0xff2193b0),
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
                                  color: Color(0xff2193b0),
                                ),
                                label: const Text(
                                  'Conform Password',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff2193b0),
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
                                Color(0xff2193b0),
                                Color(0xff6dd5ed),
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
                                          builder: (context) =>
                                              LoginScreen()));
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
