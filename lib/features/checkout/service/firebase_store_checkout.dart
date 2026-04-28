import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/checkout/model/checkout_order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseStoreCheckout {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  void createOrder(CheckoutOrderModel order) async {
    String ?userId = await LocalStorageService.getUserId();
    await _firebaseFirestore
        .collection('orders')
        .doc(userId)
    .set(order.toJson());
  }
}
