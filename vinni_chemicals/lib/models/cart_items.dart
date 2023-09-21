class CartItem {
  final String productName;
  final double price;
  final double discount;
  final double finalPrice;
  double quantity;

  CartItem(this.productName, this.price, this.discount, this.finalPrice, this.quantity);
}
