import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/progress_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class StartPage extends StatelessWidget {
  // Future<void> _startChallenge(BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('start_date', DateTime.now().toIso8601String());
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProgressPage()));
  // }

  Future<void> _startChallenge(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final startDate = DateTime.now();

    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'start_date': startDate,
        'total_days': 50,
        'last_opened': FieldValue.serverTimestamp(),
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ProgressPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Center(
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           backgroundColor: Colors.pink[200],
      //           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      //         ),
      //         onPressed: () => _startChallenge(context),
      //         child: const Text('Start challenge', style: TextStyle(color: Colors.white)),
      //       ),
      //     ),
      //     const SizedBox(height: 16),
      //     const Text('A straight 50 days challenge', style: TextStyle(color: Colors.black87)),
      //   ],
      // ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),

          // Overlaying content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'no fap no gap !!',
                      style: TextStyle(
                        color: Color(0xffff92d7),
                        fontStyle: FontStyle.italic,
                        fontFamily: "Open_Sans",
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'A STRAIGHT 50 DAYS\nCHALLENGE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xfffef4f5),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        height: 1.3,
                        fontFamily: "Open_Sans",
                      ),
                    ),
                    const SizedBox(height: 38),
                    ElevatedButton(
                      onPressed: () => _startChallenge(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFaac0f9),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Start challenge',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xfffef4f5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
