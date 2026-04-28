import 'package:chicly_store/features/profile/services/update_service.dart';
import 'package:flutter/material.dart';

void showPasswordDialog(
  BuildContext context,


) {
  String password = "";

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Update Email"),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
          TextField(
              onChanged: (value) => password = value,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            )
          ],
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          TextButton(
            onPressed: () async {
           

             UpdateService.resetPassword(context, password);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}


void showDeleteAccountDialog(
  BuildContext context,


) {


  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Are you sure Delete your account?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),

          TextButton(
            onPressed: () async {
           

             UpdateService.deleteGoogleUser(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
