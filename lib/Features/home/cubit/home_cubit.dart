import 'package:e_commerce/Features/home/cubit/home_state.dart';
import 'package:e_commerce/Features/home/models/product_model.dart';
import 'package:e_commerce/core/services/firebase_sevices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());
  late List<ProductModel> products;

  void getHomeData() async {
    emit(HomeLoadingState());
    try {
      products = await FirebaseServices.getAllProducts();
      emit(HomeSuccessState(products));
    } catch (e) {
      throw Exception('Error getting products: $e');
    }
  }
}
