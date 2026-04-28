import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({super.key});

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return ListTile(
      leading: isDark
          ? Icon(Icons.nightlight_round, size: 30)
          : Icon(Icons.wb_sunny, size: 30),
      title: Text("Theme", style: TextStyle(fontSize: 20)),
      trailing: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Switch(
            value: isDark,
            onChanged: (value) {
              theme.toggleDarkMode();
            },
          ),
        ),
      ),
    );
  }
}
