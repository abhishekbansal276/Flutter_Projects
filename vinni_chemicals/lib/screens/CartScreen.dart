import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vinni_chemicals/utils.dart';
import '../providers/cart_providers.dart';
import 'BillingScreen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreen createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;
    final noOfItems = cartProvider.noOfItems();

    if (noOfItems > 0) {
      return Stack(
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
                "Your Cart",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 20,
                  color: Color(0xff11998e),
                ),
              ),
            )),
            body: Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin:
                          const EdgeInsets.only(right: 20, left: 20, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cartItems[index].productName,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 18,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                    onTap: () {
                                      cartProvider.removeFromCart(
                                          cartItems[index].productName);
                                      Utils.toastMessage("Removed from cart");
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
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
                          const SizedBox(height: 10),
                          TextFormField(
                            style: const TextStyle(
                              fontFamily: 'MontserratLight',
                              fontSize: 15,
                            ),
                            keyboardType: TextInputType.number,
                            initialValue: cartItems[index].quantity.toString(),
                            onChanged: (newValue) {
                              double value = double.tryParse(newValue) ?? 0.0;
                              if (value < 1) {
                                cartProvider.updateQuantity(
                                    cartItems[index].productName, 1);
                              } else {
                                cartProvider.updateQuantity(
                                    cartItems[index].productName, value);
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter quantity (in ltr)",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
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
                                label: const Text(
                                  'Quantity (in ltr)',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'MontserratLight',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff11998e),
                                  ),
                                )),
                          ),
                        ],
                      ));
                },
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 20,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: const Color(0xff11998e),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BillingScreen()));
              },
              child: const Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ],
      );
    } else {
      return Scaffold(
        appBar: AppBar(
            title: Container(
          decoration: BoxDecoration(
            color: const Color(0xff38ef7d).withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
          ),
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: const Text(
            "Your Cart",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              color: Color(0xff11998e),
            ),
          ),
        )),
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(
                  top: 30, bottom: 10, left: 20, right: 20),
              child: Icon(
                Icons.card_travel_outlined,
                size: 60,
                color: const Color(0xff11998e).withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Oops! Your shopping bag is empty.",
                style: TextStyle(
                    color: const Color(0xff11998e).withOpacity(0.6),
                    fontFamily: 'Montserrat',
                    fontSize: 15),
              ),
            )
          ],
        ),
      );
    }
  }
}
