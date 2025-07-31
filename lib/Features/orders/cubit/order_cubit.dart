import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  Future<void> getOrders() async {
    try {
      emit(OrderLoading());
      final orders = FirebaseServices.getUserOrders(
        FirebaseAuth.instance.currentUser!.uid,
      );
      // emit(OrderSuccess(orders: orders));
    } catch (e) {
      emit(OrderFailure(message: e.toString()));
    }
  }
}
