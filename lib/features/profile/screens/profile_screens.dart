import 'package:chicly_store/core/theme/theme_notifier.dart';
import 'package:chicly_store/core/utils/snack_bar.dart';
import 'package:chicly_store/features/auth/presentation/auth/service/firebase_auth_service.dart';
import 'package:chicly_store/core/constant/local_storage_service.dart';
import 'package:chicly_store/features/profile/widget/change_theme.dart';
import 'package:chicly_store/features/profile/widget/edit_tile.dart';
import 'package:chicly_store/features/profile/services/update_service.dart';
import 'package:chicly_store/features/profile/widget/profile_divider.dart';
import 'package:chicly_store/features/profile/widget/show_password_dialog.dart';
import 'package:chicly_store/features/profile/widget/show_update_email_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:rt_awesome_snackbar_content/rt_awesome_snackbar_content.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({super.key});

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  String? name;
  String? email;
  String? phone;
  bool isEdinting = false;
  bool isEditingPassword = false;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    name = await LocalStorageService.getName();
    email = await LocalStorageService.getEmail();
    phone = await LocalStorageService.getPhone();

    print("Name: $name, Email: $email, Phone: $phone");

    setState(() {});
  }

  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final isDark = theme.isDarkMode;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            spacing: 20,
            children: [
              SizedBox(height: 20),
              Text("Profile", style: GoogleFonts.acme(fontSize: 35)),
              SizedBox(height: 20),
              EditTile(
                icon: Icons.person,
                title: "Name",
                value: name.toString(),

                onSave: (String value) {
                  UpdateService.updateName(value);
                  name = value;
                },
              ),
              ProfileDivider(),

              ListTile(
                leading: Icon(Icons.email, size: 30),
                title: Text("Email", style: TextStyle(fontSize: 20)),
                subtitle: Text(email ?? ""),

                trailing: TextButton(
                  child: Text("Edit"),
                  onPressed: () {
                    showUpdateEmailDialog(context, (email, password) {
                      UpdateService.updateEmail(context, password, email);
                      setState(() {
                        this.email = email;
                      });
                    });
                  },
                ),
              ),

              ProfileDivider(),
              EditTile(
                icon: Icons.phone,
                title: "Phone",
                value: phone.toString(),
                onSave: (String value) {
                  UpdateService.updatePhone(value);
                  phone = value;
                  setState(() {});
                },
              ),
              ProfileDivider(),

              ListTile(
                leading: Icon(Icons.password, size: 30),
                title: Text("Password", style: TextStyle(fontSize: 20)),

                trailing: TextButton(
                  onPressed: () {
                    setState(() {
                      isEditingPassword = !isEditingPassword;
                      if (isEditingPassword) {
                        UpdateService.resetPassword(context, email.toString());
                      }
                    });
                  },
                  child: isEditingPassword ? Text("Check email") : Text("Edit"),
                ),
              ),
              ProfileDivider(),

              ChangeTheme(),
              ProfileDivider(),
              ListTile(
                leading: Icon(Icons.delete, size: 30),
                title: Text("Delete Account", style: TextStyle(fontSize: 20)),
                trailing: TextButton(
                  child: Text("Delete"),
                  onPressed: () async {
                    String kindOfLogin = await UpdateService.KnowKindOfLogin(
                      context,
                    );
                    if (kindOfLogin == "google") {
                      showDeleteAccountDialog(context);
                    } else {
                      showPasswordDialog(context);
                    }
                  },
                ),
              ),
              ProfileDivider(),

              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      logout(context);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
