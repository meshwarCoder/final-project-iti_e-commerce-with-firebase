import 'package:e_commerce/Features/cart/cubit/cart_state.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  void getCartItems() async {
    emit(CartLoadingState());
    try {
      final cartItems = await FirebaseServices.getCartItems(
        FirebaseServices.getCurrentUser()!.uid,
      );
      emit(CartSuccessState(cartItems));
    } catch (e) {
      emit(CartErrorState(e.toString()));
    }
  }
}
