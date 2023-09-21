import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinni_chemicals/screens/payment.dart';

import '../providers/cart_providers.dart';
import '../utils.dart';

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreen createState() => _BillingScreen();
}

class _BillingScreen extends State<BillingScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final noOfItems = cartProvider.noOfItems();
    double totalFinalPrice = 0; // Initialize total final price
    for (var cartItem in cartItems) {
      totalFinalPrice += (cartItem.finalPrice * cartItem.quantity);
    }

    return (Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              title: Container(
            decoration: BoxDecoration(
              color: const Color(0xff38ef7d).withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            ),
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: const Text(
              "Billing Area",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20,
                color: Color(0xff11998e),
              ),
            ),
          )),
          body: Column(
            // margin: const EdgeInsets.only(bottom: 60),
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin:
                          const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
                      child: Material(
                        borderRadius: BorderRadius.circular(6),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems[index].productName,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 18,
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cartItems[index].price.toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${cartItems[index].discount} %",
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        cartItems[index].finalPrice.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "Quantity: ${cartItems[index].quantity}",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Final price: ₹${(cartItems[index].finalPrice * cartItems[index].quantity).toStringAsFixed(2)}/-",
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: Text(
                  "₹${totalFinalPrice.toStringAsFixed(2)}/-",
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color(0xff11998e),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(data: totalFinalPrice.toStringAsFixed(2))));
            },
            child: const Icon(
              Icons.payments,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    ));
  }
}
