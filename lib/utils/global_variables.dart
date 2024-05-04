import 'package:fake_vision/screens/add_post_screen.dart';
import 'package:fake_vision/screens/feed_screen.dart';
import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/screens/profile_screen.dart';
import 'package:fake_vision/screens/scan_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 500;

List<Widget> homeScreenItems = [
  const ScanScreen(),
  const AddPostScreen(),
  const FeedScreen(),
  ProfileScreenWrapper(),
];

class ProfileScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ProfileScreen(uid: snapshot.data!.uid);
        } else {
          // User is not logged in, handle accordingly
          return const LoginScreen();
        }
      },
    );
  }
}
