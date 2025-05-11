import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:flutter/material.dart';
import 'package:instagram_series/Screens/bottomnav/bottomnav.dart';
import 'package:instagram_series/Widgets/uihelper.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Colors.black;
    final Color buttonTextColor = Colors.white;
    final Color fieldTextColor = Colors.black;
    final Color fieldFillColor = Colors.white.withOpacity(0.7);
    final Color linkTextColor = Colors.black;
    final Color semiTransparentText = Colors.black.withOpacity(0.7);

    // Firebase Authentication logic
    Future<void> _loginUser() async {
      try {
        final String email = emailController.text.trim();
        final String password = passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          UiHelper.showToast("Please enter both email and password.");
          return;
        }

        // Firebase Authentication
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Check if login is successful
        if (userCredential.user != null) {
          // Successful login, navigate to bottom navigation screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavScreen()),
          );
        }
      } catch (e) {
        // If error occurs (wrong email/password)
        UiHelper.showToast("Invalid email or password.");
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 241, 153, 183),
              Color.fromARGB(255, 218, 126, 156),
              Color.fromARGB(255, 209, 115, 147),
              Color.fromARGB(255, 230, 123, 158),
              Color.fromARGB(255, 231, 103, 146),
              Color.fromARGB(255, 214, 51, 105),
              Color.fromARGB(255, 190, 70, 110),
              Color.fromARGB(255, 145, 41, 76),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Center(child: UiHelper.CustomImage(imgurl: "logo.png")),
                  const SizedBox(height: 30),

                  // Email field
                  UiHelper.CustomTextField(
                    controller: emailController,
                    text: "Email",
                    tohide: false,
                    textColor: fieldTextColor,
                    fillColor: fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 15),

                  // Password field
                  UiHelper.CustomTextField(
                    controller: passwordController,
                    text: "Password",
                    tohide: true,
                    textColor: fieldTextColor,
                    fillColor: fieldFillColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 8),

                  // Forgot Password - shifted slightly to left
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Center(
                      child: UiHelper.CustomTextButton(
                        text: "Forgot password?",
                        textColor: linkTextColor,
                        callback: () {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Log In Button
                  UiHelper.CustomButton(
                    callback: _loginUser, // Login button action updated
                    buttonname: "Log In",
                    backgroundColor: backgroundColor,
                    textColor: buttonTextColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 10),

                  // OR Text
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: semiTransparentText,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Facebook Login in white box
                  Container(
                    height: 50,
                    width: 343,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: UiHelper.CustomImage(imgurl: "Icon.png"),
                        ),
                        const SizedBox(width: 8),
                        UiHelper.CustomTextButton(
                          text: "Log in with Facebook",
                          textColor: fieldTextColor,
                          callback: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Google Login in white box
                  Container(
                    height: 50,
                    width: 343,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: UiHelper.CustomImage(imgurl: "google_icon.png"),
                        ),
                        const SizedBox(width: 8),
                        UiHelper.CustomTextButton(
                          text: "Log in with Google",
                          textColor: fieldTextColor,
                          callback: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Sign Up Prompt Below
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: 14,
                          color: semiTransparentText,
                        ),
                      ),
                    ],
                  ),
                  UiHelper.CustomTextButton(
                    text: "Sign Up",
                    textColor: linkTextColor,
                    fontWeight: FontWeight.bold,
                    callback: () {},
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}