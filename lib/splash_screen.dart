// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_with_firebase/start_challenge.dart';
// import 'package:flutter_with_firebase/progress_page.dart';


// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkChallenge();
//     });
//   }

//   Future<void> _checkChallenge() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool hasChallenge = prefs.containsKey('start_date');
//     if (!mounted) return;
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (_) => hasChallenge ? ProgressPage() : StartPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'progress_page.dart';
import 'start_challenge.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkUserAndProgress();
    });
  }

  Future<void> _checkUserAndProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle unauthenticated user (optional: navigate to login page)
      return;
    }

    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    final hasChallenge = doc.exists && doc.data()?['start_date'] != null;

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => hasChallenge ? ProgressPage() : StartPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
