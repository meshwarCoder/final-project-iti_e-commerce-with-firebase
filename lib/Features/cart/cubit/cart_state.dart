import 'package:e_commerce/Features/cart/models/cart_model.dart';

class CartState {}

class CartLoadingState extends CartState {}

class CartErrorState extends CartState {
  final String message;
  CartErrorState(this.message);
}

class CartSuccessState extends CartState {
  final List<CartItemModel> cartItems;
  CartSuccessState(this.cartItems);
}
