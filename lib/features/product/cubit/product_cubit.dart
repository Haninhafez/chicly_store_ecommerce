import 'package:bloc/bloc.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:chicly_store/features/product/service/get_product.dart';
import 'package:dio/dio.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {

  ProductCubit() : super(ProductInitial());
  List <ProductModel> products = [];
  getProducts() async {
    emit(ProductLoading());
    try {
       products = await GetProduct(Dio()).getProducts();
      emit(ProductSuccess(products: products));
    } on Exception catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
