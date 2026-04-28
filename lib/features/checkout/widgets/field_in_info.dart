import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FieldInInfo extends StatefulWidget {
  const FieldInInfo({
    super.key,
    this.label,
    this.initial,
    required this.onSaved,
  });

  final String? label;
  final String? initial;
  final void Function(String?) onSaved;

  @override
  State<FieldInInfo> createState() => _FieldInInfoState();
}

class _FieldInInfoState extends State<FieldInInfo> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        textInputAction: TextInputAction.next,

        onSaved: (newValue) {
          widget.onSaved(
            newValue != null && newValue.trim().isNotEmpty ? newValue : null,
          );
        },
        validator: (value) {
          if (value != null && value.trim().isEmpty) {
            return 'Please enter your $widget.label';
          }
          return null;
        },
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF2B5CE6)),
          ),
          labelText: widget.label,
          hintText: widget.initial,
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          labelStyle: const TextStyle(fontSize: 12),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
