import 'package:ecommerce_mobile_app/data/models/category_model.dart';
import 'package:ecommerce_mobile_app/data/models/product_model.dart';
import 'package:ecommerce_mobile_app/data/repositories/product_repository.dart';
import 'package:ecommerce_mobile_app/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// App State
class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryModel category;
  CategoryProductCubit(this.category) : super(CategoryProductInitialState()) {
    _initialize();
  }

  final ProductRepository _productRepository =
      ProductRepository(); // service or api

  void _initialize() async {
    emit(CategoryProductLodingState(state.products));
    try {
      List<ProductModel> products =
          await _productRepository.fetchProductsByCategory(category.sId!);
      emit(CategoryProductLoadedState(products));
    } catch (ex) {
      emit(
        CategoryProductErrorState(ex.toString(), state.products),
      );
    }
  }
}
