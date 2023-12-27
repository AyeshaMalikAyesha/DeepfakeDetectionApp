import 'package:fake_vision/models/daily_info_model.dart';
import 'package:fake_vision/responsive/responsive_admin.dart';
import 'package:fake_vision/screens/add_new_admin.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';

class SelectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 1 : 1,
            childAspectRatio: _size.width < 650 ? 1.5 : 1,
          ),
          tablet: InformationCard(),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.3,
          ),
        ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    // Adjust the itemCount based on your data
    // int itemCount = dailyDatas.length;
    int itemCount = 1;

    if (itemCount <= 1) {
      // For single or no items, center the widget
      return Container(
        child: Center(
          child: itemCount > 0
              ? MiniInformationWidget(dailyData: dailyDatas[0])
              : Container(),
        ),
      );
    } else {
      // For multiple items, use GridView
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) =>
            MiniInformationWidget(dailyData: dailyDatas[index]),
      );
    }
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.dailyData,
  }) : super(key: key);
  final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          gradient: navColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: widget.dailyData.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(
                    widget.dailyData.icon,
                    color: widget.dailyData.color,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "New Admin",
                      style: customTextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    IconButton(
                        icon: Icon(Icons.create),
                        iconSize: 18,
                        color: whiteColor,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => AddNewAdmin()),
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Container(
            child: Row(
      children: [
        Icon(
          Icons.verified,
          color: blueColor,
        ),
        SizedBox(
          width: 25,
        ),
        Text('Please wait. Generating form..'),
      ],
    ))));
  }
}
