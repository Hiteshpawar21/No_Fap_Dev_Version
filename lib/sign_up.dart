import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/login.dart';
import 'package:flutter_with_firebase/splash_screen.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final UserCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
      print(UserCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 26, right: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'No Fap Challenge',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff6c7bcc),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Open_Sans"),
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),),
                      labelStyle: TextStyle(
                          fontFamily: "Open_Sans",
                          fontSize: 15,
                          fontStyle: FontStyle.italic)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 13),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelStyle: TextStyle(
                          fontFamily: "Open_Sans",
                          fontSize: 15,
                          fontStyle: FontStyle.italic)),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 17),
              // ElevatedButton(
              //   onPressed: () async {
              //     await createUserWithEmailAndPassword();
              //   },
              //   child: const Text('Sign Up'),
              // ),

              SizedBox(
                width: 105, // Set your desired width
                height: 30, // Set your desired height
                child: ElevatedButton(
                  onPressed: () async {
                    await createUserWithEmailAndPassword();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xfffdf288), // 🔴 Background color
                    foregroundColor:
                        const Color(0xffee4176), // ✅ Text/Icon color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Open_Sans',
                        fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                        color: Color(
                          0xff6c7bcc,
                        ),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Open_Sans"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      // Navigate to Sign In screen or perform logic
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                          color: Color(
                            0xffee4176,
                          ),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Open_Sans"),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
