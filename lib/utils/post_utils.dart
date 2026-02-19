import 'package:authenticationfire/utils/utils.dart';
import 'package:authenticationfire/view_models/post_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PostUtils {
  static Future<void> showUpdateDialoge({
    required BuildContext context,
    required PostViewModel viewModel,
    required String title,
    required String id,
    required String firebaseKey,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _nameEditingController = TextEditingController(
          text: title,
        );
        TextEditingController _IDEditingController = TextEditingController(
          text: id,
        );
        return AlertDialog(
          title: Text("Update"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameEditingController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _IDEditingController,
                  decoration: InputDecoration(
                    labelText: "ID",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                viewModel.updatePost(
                  key: firebaseKey,
                  name: _nameEditingController.text.trim(),
                  id: _IDEditingController.text.trim(),
                  context: context,
                );
              },
              child: Text("Update", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
  }
}
