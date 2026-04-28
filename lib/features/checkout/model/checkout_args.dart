import 'package:chicly_store/features/product/model/product_model.dart';

class CheckoutArgs {
  final double totalAmount;
  final  Map<int,int> cartProudctsItem;

  CheckoutArgs({required this.totalAmount, required this.cartProudctsItem});

}