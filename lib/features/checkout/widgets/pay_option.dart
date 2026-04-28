import 'package:flutter/material.dart';

class PayOption extends StatefulWidget {
  const PayOption({
    super.key,
    this.value,
    this.icon,
    this.label,
    required this.paymentMethod,
    required this.isSelected,
    required this.payment,
  });
  
  final String? value;
  final IconData? icon;
  final String? label;
  final bool isSelected;
  final String payment;
  final Function(String payment, bool isSelected) paymentMethod;

  @override
  State<PayOption> createState() => _PayOptionState();
}

class _PayOptionState extends State<PayOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.paymentMethod(widget.value ?? '', true);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isSelected ? const Color(0xFF2B5CE6) : Colors.grey.shade300,
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: widget.value!,
              groupValue: widget.payment,
              onChanged: (v) {
                if (v != null) {
                  widget.paymentMethod(v, true);
                }
              },
              activeColor: const Color(0xFF2B5CE6),
              visualDensity: VisualDensity.compact,
            ),
            Icon(widget.icon, size: 20, color: Colors.black54),
            const SizedBox(width: 8),
            Text(widget.label!, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}