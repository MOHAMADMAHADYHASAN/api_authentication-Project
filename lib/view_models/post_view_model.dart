import 'package:authenticationfire/ui/auth/loginScreen.dart';
import 'package:authenticationfire/utils/dataServerUrl/data_serverUrl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class PostViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _ref = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:ServerUrl.databaseUrl,
  ).ref("post");

  Stream<DatabaseEvent> get postsStream => _ref.onValue;
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool true_false) {
    _loading = true_false;
    notifyListeners();
  }


  // ===================== delete LOGIC =====================
  Future<void> deletePost(String key, BuildContext context) async {
    try {
      await _ref.child(key).remove();
      if (context.mounted) {
        utils.snakBar("Post Deleted", context);
      }
    } catch (e) {
      await _ref.child(key).remove();
      if (context.mounted) {
        utils.snakBar("Post Deleted", context);
      }
    }
  }

  // ===================== UPDATE LOGIC =====================
  Future<void> updatePost({
    required String key,
    required String name,
    required String id,
    required BuildContext context,
  }) async {
    try {
      await _ref.child(key).update({"name": name, "ID": id});
      if (context.mounted) {
        Navigator.pop(context);
        utils.snakBar("Updated Successfully", context);
      }
    } catch (e) {
      if (context.mounted) utils.snakBar(e.toString(), context);
    }
  }

  // ===================== add post LOGIC =====================
  Future<void> addPost(String title, BuildContext context) async {
    setLoading(true);

    try {
      String id = DateTime.now().microsecondsSinceEpoch.toString();

      await _ref.child(id).set({"ID": id, "name": title});
      setLoading(false);
      if (context.mounted) {
        utils.snakBar("Successfully added", context);
        Navigator.pop(context);
      }
    } catch (e) {
      setLoading(false);
      if (context.mounted) {
        utils.snakBar(e.toString(), context);
      }
    }
  }
}
