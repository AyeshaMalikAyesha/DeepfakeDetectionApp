import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fake_vision/models/reported_user_model.dart';
import 'package:fake_vision/screens/home/home_screen.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ReportedUsers extends StatelessWidget {
  const ReportedUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: colorStatusBar, // Set the status bar color
          statusBarIconBrightness: Brightness.light, // Status bar icons' color
        ),
        automaticallyImplyLeading: false,
        elevation: 5.0, //shadow to app bar
        flexibleSpace: Stack(
          children: [
            // Clipping the background image to the bounds of the AppBar
            ClipRect(
              child: Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Images/bg2.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color.fromARGB(255, 34, 34, 34)
                            .withOpacity(0.5), // This controls the black tint
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Actual AppBar content
            Padding(
              padding: const EdgeInsets.only(left: 1.0, top: 30),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    "Reported Users",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Inter',
                      color: whiteColor,
                    ),
                  ), // Add some spacing
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: const BorderRadius.all(Radius.circular(0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Reported By",
                        style: customTextStyle,
                      ),
                    ),
                    DataColumn(
                      label: Text("Reported To", style: customTextStyle),
                    ),
                    DataColumn(
                      label: Text("Post Id", style: customTextStyle),
                    ),
                    DataColumn(
                      label: Text("Options", style: customTextStyle),
                    ),
                  ],
                  rows: List.generate(
                    reportedUsers.length,
                    (index) =>
                        reportedUserDataRow(reportedUsers[index], context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow reportedUserDataRow(ReportedUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.reported_by!,
                maxLines: 1,
                style: customTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(userInfo.reported_to!, style: customTextStyle)),
      DataCell(Text(userInfo.post_id!, style: customTextStyle)),
      DataCell(
        Row(
          children: [
            TextButton(
              child: Text('Warning',
                  style:
                      TextStyle(color: Colors.redAccent, fontFamily: 'Inter')),
              onPressed: () {},
            ),
            SizedBox(
              width: 6,
            ),
            TextButton(
              child: Text("Delete",
                  style:
                      TextStyle(color: Colors.redAccent, fontFamily: 'Inter')),
              onPressed: () {
                deleteDialogBox(context,
                    "Are you sure want to delete '${userInfo.reported_to}'?");
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}

Future deleteDialogBox(BuildContext context, String text) async {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    animType: AnimType.BOTTOMSLIDE,
    title: "Confirmation",
    titleTextStyle: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
        fontSize: 20),
    desc: text,
    descTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
    btnCancelText: "Cancel",
    buttonsTextStyle: TextStyle(fontFamily: 'Inter', color: whiteColor),
    btnCancelColor: const Color.fromARGB(255, 167, 207, 240),
    btnCancelOnPress: () {},
    btnOkText: "Delete",
    buttonsBorderRadius: BorderRadius.circular(25),
    btnOkColor: redColor,
    dialogBackgroundColor: Color.fromARGB(255, 18, 69, 110),
    btnOkOnPress: () {},
  )..show();
}
