import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/product_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitialState()) {
    _initialize();
  }

  final ProductRepository _productRepository =
      ProductRepository(); // service or api

  void _initialize() async {
    emit(ProductLodingState(state.products));

    try {
      List<ProductModel> categories =
          await _productRepository.fetchAllProducts();
      emit(ProductLoadedState(categories));
    } 
    catch (ex) {
      emit(
        ProductErrorState(ex.toString(), state.products),
      );
    }
  }
}
