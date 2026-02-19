import 'dart:ui';
import 'package:authenticationfire/utils/utils.dart';
import 'package:authenticationfire/view_models/auth_view_model.dart';
import 'package:authenticationfire/widgets/round_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;

  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _verifingController = TextEditingController();

  @override
  void dispose() {
    _verifingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    // ================== Pinput (Glass Style) ==================

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),

        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),

        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.white, width: 1.5),
      borderRadius: BorderRadius.circular(10),
      color: Colors.white.withOpacity(0.2),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white.withValues(alpha: 0.1),
      border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.8)),
    );

    return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon and title
                  const Icon(
                    Icons.lock_open_rounded,
                    size: 70,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please enter the 6-digit code sent to your phone",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 40),

                  // ==================== GLASS CONTAINER START ====================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Pinput
                            Pinput(
                              length: 6,
                              controller: _verifingController,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,

                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              cursor: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 9),
                                    width: 22,
                                    height: 1,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onCompleted: (otp) {
                                if (kDebugMode) {
                                  print("Completed: $otp");
                                }
                                authViewModel.verifyOTP(
                                  widget.verificationId,
                                  otp,
                                  context,
                                );
                              },
                            ),

                            const SizedBox(height: 40),

                            Consumer<AuthViewModel>(
                              builder: (context, value, child) {
                                return RoundButton(
                                  title: "Verify & Login",
                                  loading:value.sendCodeLoading,

                                  onPress: () {
                                    String smsCode = _verifingController.text
                                        .trim();
                                    if (smsCode.isEmpty || smsCode.length < 6) {
                                      utils.snakBar(
                                        "Please enter valid 6 digit code",
                                        context,
                                      );
                                      return;
                                    }
                                    authViewModel.verifyOTP(
                                      widget.verificationId,
                                      smsCode,
                                      context,
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ==================== GLASS CONTAINER END ====================
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Change Phone Number?",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
