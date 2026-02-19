import 'package:authenticationfire/ui/auth/verify_code.dart';
import 'package:authenticationfire/ui/posts/post_screen.dart';
import 'package:authenticationfire/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main/main_screen.dart';
import '../ui/auth/loginScreen.dart';

class AuthViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //====================================== alada alada loading toiri kora holo jno loading gula onno pafer loading e effect ma fele
  bool _loginLoading = false;
  bool _signUpLoading = false;
  bool _phoneLoading = false;
  bool _sendCodeLoading = false;

  bool get loginLoading => _loginLoading;

  bool get signUpLoading => _signUpLoading;

  bool get phoneLoading => _phoneLoading;

  bool get sendCodeLoading => _sendCodeLoading;

  void setLoginLoading(bool true_false) {
    _loginLoading = true_false;
    notifyListeners();
  }

  void setSignUpLoading(bool true_false) {
    _signUpLoading = true_false;
    notifyListeners();
  }

  void setPhoneLoading(bool true_false) {
    _phoneLoading = true_false;
    notifyListeners();
  }

  void setOtpLoading(bool true_false) {
    _sendCodeLoading = true_false;
    notifyListeners();
  }

  //==================================================LOGIN======================================
  Future<void> login(String email,
    String password,
    BuildContext context,) async {
    setLoginLoading(true);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setLoginLoading(false);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setLoginLoading(false);
      // Await sesh tai age cheack kora vlo widget mounted kina !!!

      if (!context.mounted) return;
      String message = e.message.toString();
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      } else if (e.code == 'invalid-credential') {
        message = "Invalid Email or Password.";
      }
      debugPrint(e.toString());
      utils.snakBar(message, context);
    } catch (e) {
      setLoginLoading(false);
      if (context.mounted) {
        utils.snakBar(e.toString(), context);
      }
    }
  }

  // ===================== LOGOUT LOGIC =====================
  Future<void> logOut(BuildContext context) async {
    try {
      await _auth.signOut();
      if (context.mounted) {
        utils.snakBar("Logged Out Successfully", context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LogInsScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) utils.snakBar(e.toString(), context);
    }
  }

  //==================================================signUp======================================
  Future<void> signUp(
    String email,
    String password,
    BuildContext context,
  ) async {
    setSignUpLoading(true);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setSignUpLoading(false);
      if (context.mounted) {
        utils.snakBar("Account Created", context);
        Navigator.pop(context);
      }
    } catch (e) {
      setSignUpLoading(false);
      utils.snakBar(e.toString(), context);
    }
  }

  //==================================================PhoneNumberVerification======================================
  Future<void> loginWithPhone(String phoneNumber, BuildContext context) async {
    if (phoneNumber.isEmpty || phoneNumber.length < 11) {
      if (context.mounted) {
        utils.snakBar("Invalid Phone Number", context);
      }
      return;
    }
    setPhoneLoading(true);

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (_) {
        setPhoneLoading(false);
      },
      verificationFailed: (FirebaseAuthException e) {
        setPhoneLoading(false);
        utils.snakBar(e.toString(), context);
      },
      codeSent: (String verificationIDAmader, int? token) {
        setPhoneLoading(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                VerifyCodeScreen(verificationId: verificationIDAmader),
          ),
        );
      },
      codeAutoRetrievalTimeout: (e) {
        setPhoneLoading(false);
      },
    );
  }

  //==================================================otp======================================
  Future<void> verifyOTP(String id, String otp, BuildContext context) async {
    setOtpLoading(true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      setOtpLoading(false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
        (route) => false,
      );
    } catch (e) {
      setOtpLoading(false);
      utils.snakBar("Invalid OTP", context);
    }
  }
}
