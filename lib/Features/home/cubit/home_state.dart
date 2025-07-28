import 'package:e_commerce/Features/home/models/product_model.dart';

class HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<ProductModel> products;
  HomeSuccessState(this.products);
}

class HomeErrorState extends HomeState {
  final String error;
  HomeErrorState(this.error);
}
