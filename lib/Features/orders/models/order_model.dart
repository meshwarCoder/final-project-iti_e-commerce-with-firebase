class Order {
  final String orderId;
  final double totalPrice;
  final List<String> products;

  Order({
    required this.orderId,
    required this.totalPrice,
    required this.products,
  });
}
