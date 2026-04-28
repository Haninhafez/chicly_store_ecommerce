import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/checkout/model/checkout_order_model.dart';
import 'package:chicly_store/features/checkout/widgets/badge.dart';
import 'package:chicly_store/features/checkout/widgets/card_in_checkout.dart';
import 'package:chicly_store/features/checkout/widgets/field_in_info.dart';
import 'package:chicly_store/features/checkout/widgets/helpers.dart';
import 'package:chicly_store/features/checkout/widgets/pay_option.dart';
import 'package:chicly_store/features/checkout/service/firebase_store_checkout.dart';
import 'package:chicly_store/features/checkout/stripe_payment/payment_manger.dart';
import 'package:chicly_store/features/checkout/widgets/payment_by_card.dart';
import 'package:chicly_store/features/product/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.subTotalAmount,
    required this.cartProductItemes,
  });
  final double subTotalAmount;
  final Map<int, int> cartProductItemes;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _payment = 'card';
  bool _saveInfo = true;
  final _promoCtrl = TextEditingController();
  bool isComplete = false;
  bool isSelected = false;
  double discount = 0;
  double totalAmount = 0;
  double tax = 0;
  CheckoutOrderModel order = CheckoutOrderModel();
  CardFieldInputDetails? cardDetails;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  void _updatePaymentMethod(String payment, bool isSelected) {
    setState(() {
      _payment = payment;
    });
  }

  void orderTotal() {
    setState(() {
      tax = widget.subTotalAmount * 15 / 100;

      totalAmount = tax + widget.subTotalAmount - discount + 10;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    orderTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Checkout',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // ── Shipping ──────────────────────────────────────────────────────
              CardInCheckout(
                icon: Icons.local_shipping_outlined,
                title: 'Shipping Information',
                child: Column(
                  children: [
                    custom_row([
                      FieldInInfo(
                        label: 'First Name',
                        initial: 'John',
                        onSaved: (value) => order.firstName = value,
                      ),
                      FieldInInfo(
                        label: 'Last Name',
                        initial: 'Doe',
                        onSaved: (value) => order.lastName = value,
                      ),
                    ]),
                    FieldInInfo(
                      label: 'Address',
                      initial: '123 Main Street',
                      onSaved: (value) => order.address = value,
                    ),
                    custom_row([
                      FieldInInfo(
                        label: 'City',
                        initial: 'New York',
                        onSaved: (value) => order.city = value,
                      ),
                      FieldInInfo(
                        label: 'ZIP Code',
                        initial: '10001',
                        onSaved: (value) => order.zipcode = value,
                      ),
                    ]),
                    custom_row([
                      FieldInInfo(
                        label: 'State',
                        initial: 'NY',
                        onSaved: (value) => order.state = value,
                      ),
                      FieldInInfo(
                        label: 'Country',
                        initial: 'United States',
                        onSaved: (value) => order.country = value,
                      ),
                    ]),
                    FieldInInfo(
                      label: 'Phone Number',
                      initial: '+1 (555) 123-4567',
                      onSaved: (value) => order.phone = value,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _saveInfo,
                          activeColor: const Color(0xFF2B5CE6),
                          onChanged: (v) => setState(() => _saveInfo = v!),
                        ),
                        const Text('Save this information for next time'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Payment ───────────────────────────────────────────────────────
              CardInCheckout(
                icon: Icons.credit_card,
                title: 'Payment Method',
                child: Column(
                  children: [
                    PayOption(
                      value: 'card',
                      icon: Icons.credit_card,
                      label: 'Credit/Debit Card',
                      paymentMethod: _updatePaymentMethod,
                      isSelected: _payment == 'card',
                      payment: _payment,
                    ),
                    PayOption(
                      value: 'cash on delivery',
                      icon: Icons.wallet,
                      label: 'Cash on Delivery',
                      paymentMethod: _updatePaymentMethod,
                      isSelected: _payment == 'cash on delivery',
                      payment: _payment,
                    ),
                    if (_payment == 'card') ...[
                      PaymentByCard(
                        onCardChanged: (card) {
                          cardDetails = card;
                        },
                      ),
                    ],
                  ],
                ),
              ),

              // ── Promo ─────────────────────────────────────────────────────────
              CardInCheckout(
                icon: Icons.local_offer_outlined,
                title: 'Promo Code',
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _promoCtrl,
                        decoration: InputDecoration(
                          hintText: 'Enter promo code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        totalAmount = widget.subTotalAmount + 15;
                        if (_promoCtrl.text == '123') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Promo code applied')),
                          );
                          setState(() {
                            discount = widget.subTotalAmount * 0.1;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid promo code')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Order Total ───────────────────────────────────────────────────
              CardInCheckout(
                title: 'Order Total',
                child: Column(
                  children: [
                    _totalRow(
                      'Subtotal',
                      '${widget.subTotalAmount.toStringAsFixed(2)} EGP',
                      grey: true,
                    ),
                    _totalRow('Shipping', '100 EGP', grey: true),
                    _totalRow('Tax', '$tax EGP', grey: true),
                    _totalRow(
                      'Discount',
                      '-${discount.toStringAsFixed(2)} EGP',
                      grey: true,
                    ),
                    const Divider(height: 24),
                    _totalRow('Total', ' ${totalAmount} EGP ', bold: true),
                    const SizedBox(height: 12),
                    // Free shipping banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.green,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Free shipping on orders over 5000 EGP ',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Trust badges
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BadgeInCheckout(
                          icon: Icons.lock_outline,
                          label: 'Secure\nPayment',
                        ),
                        BadgeInCheckout(
                          icon: Icons.verified_user_outlined,
                          label: 'SSL\nEncrypted',
                        ),
                        BadgeInCheckout(
                          icon: Icons.refresh,
                          label: 'Free\nReturns',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Place Order button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (formKey.currentState!.validate()) {
                            if (_payment == 'cash on delivery') {
                              order.totalPrice = totalAmount;
                              order.cartItems = widget.cartProductItemes;
                              order.paymentMethod = _payment;
                              FirebaseStoreCheckout().createOrder(order);
                              showSnackBar(
                                context: context,
                                message:
                                    'Order placed and will be pay on delivery!',
                                color: ColorApp.cusBlue,
                                title: 'Success',
                                contentType: ContentType.success,
                              );
                              Navigator.pop(context);
                            } else if (cardDetails != null &&
                                cardDetails!.complete) {
                              formKey.currentState!.save();
                              await PaymentManger.makePayment(totalAmount, 'egp');
                              showSnackBar(
                                context: context,
                                message:
                                    'Order placed !',
                                color: ColorApp.cusBlue,
                                title: 'Success',
                                    contentType: ContentType.success,
                              );
                              order.totalPrice = totalAmount;
                              order.cartItems = widget.cartProductItemes;
                              order.paymentMethod = _payment;
                              FirebaseStoreCheckout().createOrder(order);
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter card details'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2B5CE6),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Place Order →',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        '← Continue Shopping',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _totalRow(
    String label,
    String amount, {
    bool grey = false,
    bool bold = false,
  }) {
    final style = TextStyle(
      fontSize: bold ? 16 : 14,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: grey ? Colors.grey : Colors.black87,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(amount, style: style),
        ],
      ),
    );
  }
}
