import 'package:fake_vision/providers/user_provider.dart';
import 'package:fake_vision/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;
  final Widget webScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.mobileScreenLayout,
    required this.webScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }
//addData() that relies on the UserProvider to refresh user-related data
//The purpose of refreshing the user data might be to fetch the latest information or perform any necessary updates.
  addData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder is a widget that builds itself based on the parent widget's constraints. 
    //It's particularly useful for creating a widget tree that depends on the parent widget's size
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        
        return widget.webScreenLayout;
      }
      return widget.mobileScreenLayout;
    });
  }
}