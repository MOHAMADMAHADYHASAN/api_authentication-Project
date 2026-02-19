import 'dart:ui';
import 'package:authenticationfire/utils/utils.dart';
import 'package:authenticationfire/view_models/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/round_button.dart';

class LoginWithPhoneNum extends StatefulWidget {
  const LoginWithPhoneNum({super.key});

  @override
  State<LoginWithPhoneNum> createState() => _LoginWithPhoneNumState();
}

class _LoginWithPhoneNumState extends State<LoginWithPhoneNum> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      // AppBar transparent kora holo
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.blueAccent],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone_iphone_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Phone Verification",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We need to register your phone number before getting started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                  const SizedBox(height: 40),

                  // ==================== GLASS CONTAINER START ====================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Consumer<AuthViewModel>(
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                //=========================phone number input feild=========================
                                TextFormField(
                                  onChanged: (text) {
                                    if (value.phoneLoading) {
                                      value.setPhoneLoading(false);
                                    }
                                  },
                                  controller: _phoneController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    letterSpacing: 1.2,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "1XXX XXXXXX",
                                    hintStyle: TextStyle(
                                      color: Colors.white.withValues(alpha:0.5),
                                    ),
                                    labelText: "Phone Number",
                                    labelStyle: const TextStyle(
                                      color: Colors.white70,
                                    ),

                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.white70,
                                    ),
                                    prefixText: "+880 ",
                                    prefixStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.white54,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30),
                                // ================== SEND CODE BUTTON ==================
                                RoundButton(
                                  title: "Send Code",
                                  loading: value.phoneLoading,
                                  onPress: () {
                                    if (value.phoneLoading) return;
                                    if (_phoneController.text.isEmpty) {
                                      utils.snakBar(
                                        "Please enter phone number",
                                        context,
                                      );
                                      return;
                                    }
                                    authViewModel.loginWithPhone(
                                      "+880${_phoneController.text}",
                                      context,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // ==================== GLASS CONTAINER END ====================
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
