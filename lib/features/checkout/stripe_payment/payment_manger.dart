
import 'package:chicly_store/features/checkout/stripe_payment/keys.env';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

abstract class PaymentManger {
  static Future<void> makePayment(double amount, String currency) async {
    try {
      String clientSecret = await _getClientSecret(
         (amount * 100).round().toString(),
        currency,
      );
    
      await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(
            email: "haninabdelhafez0@gmail.com",
          ),
        ),
      ),
    );
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${StripeKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      data: {'amount': amount, 'currency': currency},
    );
    return response.data["client_secret"];
  }

  static Future<void> _initPaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,

        merchantDisplayName: "Hanin",
      ),
    );
  }
}
