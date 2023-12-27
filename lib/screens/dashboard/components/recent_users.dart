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
        color: blueColor,
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
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                          title: Center(
                            child: Column(
                              children: [
                                Icon(Icons.warning_outlined,
                                    size: 36, color: Colors.red),
                                SizedBox(height: 20),
                                Text("Confirm Deletion"),
                              ],
                            ),
                          ),
                          content: Container(
                            color: secondaryColor,
                            height: 70,
                            child: Column(
                              children: [
                                Text(
                                    "Are you sure want to delete '${userInfo.name}'?"),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.grey),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: Text("Cancel")),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton.icon(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 14,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red),
                                        onPressed: () {},
                                        label: Text("Delete"))
                                  ],
                                )
                              ],
                            ),
                          ));
                    });
              },
              // Delete
            ),
          ],
        ),
      ),
    ],
  );
}
