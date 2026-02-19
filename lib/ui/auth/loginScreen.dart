import 'dart:ui';
import 'package:authenticationfire/ui/auth/login_with_phone_num.dart';
import 'package:authenticationfire/ui/auth/signupScreen.dart';
import 'package:authenticationfire/utils/utils.dart';
import 'package:authenticationfire/view_models/auth_view_model.dart';
import 'package:authenticationfire/widgets/customised_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:authenticationfire/widgets/round_button.dart';
import 'package:provider/provider.dart';

class LogInsScreen extends StatefulWidget {
  const LogInsScreen({super.key});

  @override
  State<LogInsScreen> createState() => _LogInsScreenState();
}

class _LogInsScreenState extends State<LogInsScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusnode = FocusNode();
  final FocusNode _passwordFocusnode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusnode.dispose();
    _passwordFocusnode.dispose();
    _obsecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      // Glass Effect bujar jonno picone color gradient kora holo
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.blueAccent],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.person_pin, size: 80, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 30),

                  // ==================== GLASS CONTAINER START ====================
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      //===== blure effect=====
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),

                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // ------------------ Email Field ------------------
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusnode,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),

                                decoration: InputDecoration(
                                  labelText: "Email Address",
                                  labelStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.white70,
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
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains("@")) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) {
                                  utils.feildFocusChange(
                                    context,
                                    _emailFocusnode,
                                    _passwordFocusnode,
                                  );
                                },
                              ),

                              SizedBox(height: 20),

                              // ------------------ Password Field ------------------
                              ValueListenableBuilder(
                                valueListenable: _obsecurePassword,
                                builder: (context, value, child) {
                                  return TextFormField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusnode,
                                    obscureText: _obsecurePassword.value,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: Colors.white70,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _obsecurePassword.value =
                                              !_obsecurePassword.value;
                                        },
                                        icon: Icon(
                                          _obsecurePassword.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.white70,
                                        ),
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
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  );
                                },
                              ),

                              const SizedBox(height: 30),
                              /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                              //------------------ Login Button ------------------
                              Consumer<AuthViewModel>(
                                builder: (context, value, child) {
                                  return RoundButton(
                                    title: "Log In",
                                    loading: value.loginLoading,
                                    onPress: () {
                                      if (value.loginLoading) return;
                                      if (_formKey.currentState!.validate()) {
                                        authViewModel.login(
                                          _emailController.text.trim(),
                                          _passwordController.text.trim(),
                                          context,
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 10),

                              // ------------------ Sign Up Row ------------------
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  //====================GLASS CONTAINER END ====================
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white54),
                  const SizedBox(height: 15),

                  // Phone Verification  ====================
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginWithPhoneNum(),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),

                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white70),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Login With Phone",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
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
