import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  String data = "";
  PaymentScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
          title: Container(
            decoration: BoxDecoration(
              color: const Color(0xff38ef7d).withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: const Text(
              "Payment",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Color(0xff11998e),
              ),
            ),
          )),
      body: Text(data),
    ));
  }
}

