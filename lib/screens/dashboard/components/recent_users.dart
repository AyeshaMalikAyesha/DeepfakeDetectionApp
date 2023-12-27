import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';
import 'package:fake_vision/models/recent_user_model.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';

class RecentUsers extends StatelessWidget {
  const RecentUsers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        gradient: navColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Users",
            style:
                TextStyle(fontFamily: 'Inter', fontSize: 20, color: whiteColor),
          ),
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
                      "Name",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "User Id",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Email",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Created",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Signed In",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Posts",
                      style: customTextStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "Options",
                      style: customTextStyle,
                    ),
                  ),
                ],
                rows: List.generate(
                  recentUsers.length,
                  (index) => recentUserDataRow(recentUsers[index], context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserDataRow(RecentUser userInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            TextAvatar(
              size: 35,
              backgroundColor: blueColor,
              textColor: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              upperCase: true,
              numberLetters: 1,
              shape: Shape.Rectangle,
              text: userInfo.name!,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(
                userInfo.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: customTextStyle,
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(
        userInfo.user_id!,
        style: customTextStyle,
      )),
      DataCell(Text(
        userInfo.email!,
        style: customTextStyle,
      )),
      DataCell(Text(
        userInfo.created!,
        style: customTextStyle,
      )),
      DataCell(Text(
        userInfo.signed_in!,
        style: customTextStyle,
      )),
      DataCell(Text(
        userInfo.posts!,
        style: customTextStyle,
      )),
      DataCell(
        Row(
          children: [
            TextButton(
              child: Text('View',
                  style: TextStyle(color: green, fontFamily: 'Inter')),
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
                deleteDialogBox(
                    context, "Are you sure want to delete '${userInfo.name}'?");
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
