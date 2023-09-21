import 'package:flutter/material.dart';
import 'package:vinni_chemicals/screens/CartScreen.dart';
import 'package:vinni_chemicals/screens/ProfileScreen.dart';
import 'package:vinni_chemicals/screens/YourOrders.dart';
import 'package:vinni_chemicals/screens/home_screen.dart';
import '../models/bottom_bar.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

enum BottomIcons { Home, Orders, Cart, Profile }

class _MainPageState extends State<MainPage> {
  BottomIcons bottomIcons = BottomIcons.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.Home
              ? const Center(
                  child: HomeScreen(),
                )
              : Container(),
          bottomIcons == BottomIcons.Cart
              ? Center(
                  child: CartScreen(),
                )
              : Container(),
          bottomIcons == BottomIcons.Orders
              ? const Center(
                  child: YourOrdersList(),
                )
              : Container(),
          bottomIcons == BottomIcons.Profile
              ? const Center(
                  child: ProfileScreen(),
                )
              : Container(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Home;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Home ? true : false,
                      icons: Icons.home,
                      text: "Home"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Cart;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Cart ? true : false,
                      icons: Icons.shopping_cart,
                      text: "Your Cart"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Orders;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Orders ? true : false,
                      icons: Icons.list,
                      text: "Your Orders"),
                  BottomBar(
                      onPressed: () {
                        setState(() {
                          bottomIcons = BottomIcons.Profile;
                        });
                      },
                      bottomIcons:
                          bottomIcons == BottomIcons.Profile ? true : false,
                      icons: Icons.person,
                      text: "Account"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
