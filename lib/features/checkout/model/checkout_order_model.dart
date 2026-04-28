import 'package:chicly_store/core/constant/local_storage_service.dart';

class CheckoutOrderModel {
  String? email=LocalStorageService.userEmail;
  String? firstName;
  String? lastName;
  String? address;
  String? city;
  String? zipcode;
  String ? state;
  String? country;
  String? phone;
  String? paymentMethod;
  double ? totalPrice;
  Map<int, int>? cartItems;

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
   
      'email': email,
      'fullName':fullName ,
      'address': address,
      'city': city,
      'zipcode': zipcode,
      'state': state,
      'country': country,
      'phone': phone,
      'paymentMethod': paymentMethod,
      'totalPrice': totalPrice,
      'cartItems': cartItems?.map(
  (key, value) => MapEntry(key.toString(), value),
),
    };
  }
}
