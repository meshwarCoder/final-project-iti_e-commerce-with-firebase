import 'package:e_commerce/Features/orders/models/order_model.dart';

class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;
  OrderSuccess({required this.orders});
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure({required this.message});
}
