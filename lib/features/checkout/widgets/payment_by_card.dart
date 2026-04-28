import 'package:chicly_store/core/constant/color_app.dart';
import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:provider/provider.dart';

class PaymentByCard extends StatelessWidget {
  PaymentByCard({super.key, required this.onCardChanged});
  final Function(stripe.CardFieldInputDetails?) onCardChanged;

  @override
  Widget build(BuildContext context) {
    bool _iscomplete = false;
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 21, 44, 109),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Color(0xFF2B5CE6),
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: stripe.CardFormField(
        autofocus: true,
        style: stripe.CardFormStyle(
          fontSize: 16,
          textColor: isDark ? ColorApp.primayLight : ColorApp.primayDark,
        ),
        onCardChanged:  onCardChanged,
      ),
    );
  }
}
