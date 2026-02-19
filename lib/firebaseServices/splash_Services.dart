import 'dart:async';

import 'package:authenticationfire/main/main_screen.dart';
import 'package:authenticationfire/ui/auth/loginScreen.dart';
import 'package:authenticationfire/ui/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';



class Splashservices {
  void isLogin(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen(

            )),
          );
        }
      });
    } else {
      Timer(Duration(seconds: 2), () {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LogInsScreen()),
          );
        }
      });
    }
  }
}
