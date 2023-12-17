import 'package:fake_vision/screens/add_post_screen.dart';
import 'package:fake_vision/screens/feed_screen.dart';
import 'package:fake_vision/screens/profile_screen.dart';
import 'package:fake_vision/screens/scan_screen.dart';
import 'package:fake_vision/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const webScreenSize = 500;

List<Widget> homeScreenItems = [
  const ScanScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const FeedScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
