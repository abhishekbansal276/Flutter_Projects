import 'package:flutter/material.dart';

import '../models/cart_items.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeFromCart(String productName) {
    _cartItems.removeWhere((item) => item.productName == productName);
    notifyListeners();
  }

  void updateQuantity(String productName, double newQuantity) {
    final cartItemIndex = _cartItems.indexWhere((item) => item.productName == productName);
    if (cartItemIndex != -1) {
      _cartItems[cartItemIndex].quantity = newQuantity;
      notifyListeners();
    }
  }

  bool isProductInCart(String productName) {
    return _cartItems.any((item) => item.productName == productName);
  }

  int noOfItems() {
    return _cartItems.length;
  }
}
