import 'package:fake_vision/screens/dashboard/components/reported_users.dart';
import 'package:fake_vision/screens/forms/input_form.dart';
import 'package:fake_vision/screens/login_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: navColor,
        ),
        child: SingleChildScrollView(
          // it enables scrolling
          child: Column(
            children: [
              DrawerHeader(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Image.asset(
                      "Images/app_logo-removebg.png",
                    ),
                  ),
                  Text("FakeVision", style: customTextStyle)
                ],
              )),
              DrawerListTile(
                title: "Dashboard",
                icon: Icons.dashboard,
                press: () {},
              ),
              DrawerListTile(
                title: "Reported Users",
                icon: Icons.report,
                press: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new ReportedUsers();
                      },
                      fullscreenDialog: true));
                },
              ),
              DrawerListTile(
                title: "Add New Admin",
                icon: Icons.admin_panel_settings,
                press: () {
                  Navigator.of(context).push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return new FormMaterial();
                      },
                      fullscreenDialog: true));
                },
              ),
              DrawerListTile(
                title: "Signout",
                icon: Icons.logout,
                press: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 17.0,
      leading: Icon(
        icon,
        color: Colors.white54,
      ),
      contentPadding: EdgeInsets.only(left: 17, top: 3),
      title: Text(
        title,
        style: customTextStyle,
      ),
    );
  }
}
