import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vinni_chemicals/utils.dart';

import '../models/cart_items.dart';
import '../providers/cart_providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List allItems = [];

  Future<void> getRecord() async {
    String uri = "http://10.0.2.2/vinni_chemicals_api/all_products.php";

    try {
      var response = await http.get(Uri.parse(uri));
      setState(() {
        allItems = jsonDecode(response.body);
      });
    } catch (e) {
      Utils.toastMessage("Please try again later");
      // print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        decoration: BoxDecoration(
          color: const Color(0xff38ef7d).withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: const Text(
          "All Products",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Color(0xff11998e),
          ),
        ),
      )),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 60),
        child: ListView.builder(
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            final cartProvider =
                Provider.of<CartProvider>(context, listen: false);
            String productName = allItems[index]["product_name"];
            bool isSelected = cartProvider.isProductInCart(productName);
            double mrp = double.parse(allItems[index]["mrp"]);
            double discount = double.parse(allItems[index]["discount"]);
            double finalPrice = mrp - (mrp * (discount / 100));

            return Container(
              margin: const EdgeInsets.only(
                  right: 10, left: 10, top: 10, bottom: 5),
              child: Material(
                borderRadius: BorderRadius.circular(6),
                elevation: 8,
                child: ListTile(
                    trailing: InkWell(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            cartProvider.removeFromCart(
                                productName); // Remove from cart
                            Utils.toastMessage("Removed from cart");
                          } else {
                            cartProvider.addToCart(CartItem(productName, mrp,
                                discount, finalPrice, 20)); // Add to cart
                            Utils.toastMessage("Added to cart");
                          }
                        });
                      },
                      child: Material(
                        elevation: 8,
                        color:
                            isSelected ? const Color(0xff11998e) : Colors.white,
                        shape: const CircleBorder(),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Icon(
                            Icons.shopping_cart,
                            color: isSelected
                                ? const Color(0xffffffff)
                                : const Color(0xff11998e),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      allItems[index]["product_name"],
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color(0xff11998e),
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "MRP:- ${allItems[index]["mrp"]}",
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Discount:- ${allItems[index]["discount"]}%",
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: Colors.black54),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Final price:- ${finalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 13,
                              fontFamily: 'Montserrat',
                              color: Colors.black54),
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
