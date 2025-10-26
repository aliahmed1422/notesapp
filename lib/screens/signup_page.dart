import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'welcome_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _firstCtrl = TextEditingController();
  final TextEditingController _lastCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  bool _hidePass = true;
  bool _hideConfirm = true;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.06,
            vertical: h * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.09,
                  ),
                ),
              ),
              SizedBox(height: h * 0.01),
              Center(
                child: Text(
                  "Fill in the details to continue",
                  style: TextStyle(fontSize: w * 0.04),
                ),
              ),
              SizedBox(height: h * 0.03),

              TextField(
                controller: _firstCtrl,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),

              TextField(
                controller: _lastCtrl,
                decoration: InputDecoration(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),

              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
              ),
              SizedBox(height: h * 0.025),

              TextField(
                controller: _passCtrl,
                obscureText: _hidePass,
                decoration: InputDecoration(
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hidePass ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
              ),
              SizedBox(height: h * 0.025),

              TextField(
                controller: _confirmCtrl,
                obscureText: _hideConfirm,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _hideConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _hideConfirm = !_hideConfirm;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w * 0.05),
                  ),
                ),
              ),
              SizedBox(height: h * 0.05),

              ElevatedButton(
                onPressed: () {
                  final first = _firstCtrl.text.trim();
                  final last = _lastCtrl.text.trim();
                  final email = _emailCtrl.text.trim();
                  final pass = _passCtrl.text.trim();
                  final confirm = _confirmCtrl.text.trim();

                  if (first.isEmpty ||
                      last.isEmpty ||
                      email.isEmpty ||
                      pass.isEmpty ||
                      confirm.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Please fill all fields",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                  } else if (pass != confirm) {
                    Get.snackbar(
                      "Error",
                      "Passwords do not match",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.orangeAccent,
                      colorText: Colors.white,
                    );
                  } else {
                    Get.snackbar(
                      "Success",
                      "Account created successfully",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                    );
                    Get.off(() => const WelcomePage());
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, h * 0.07),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.08),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: w * 0.05,
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: w * 0.04),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(() => const WelcomePage());
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: w * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
