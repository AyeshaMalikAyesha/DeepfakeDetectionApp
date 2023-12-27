import 'package:fake_vision/responsive/responsive_admin.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fake_vision/models/daily_info_model.dart';

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
      return Center(
        child: itemCount > 0
            ? MiniInformationWidget(dailyData: dailyDatas[0])
            : Container(),
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
  bool _visible = false;

  TextEditingController _controller = TextEditingController();

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }

  int charLength = 0;

  bool status = false;
  bool _closeIcon = true;

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });

    if (charLength >= 6) {
      setState(() {
        _closeIcon = _closeIcon;
        status = true;
      });
    } else {
      setState(() {
        _closeIcon = !_closeIcon;
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        visible: !_visible,
                        child: Icon(Icons.create, size: 18),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  _toggle();
                }),
            SizedBox(
              height: 8,
            ),
            Visibility(
              visible: _visible,
              child: new Container(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                  child: new Material(
                    elevation: 10.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: new ListTile(
                      title: new TextField(
                        controller: _controller,
                        decoration: new InputDecoration(
                          hintText: 'Enter Email',
                          border: InputBorder.none,
                        ),
                        onChanged: _onChanged,
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: () {
                          _controller.clear();
                          _toggle();
                          status = false;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: status,
              child: Container(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
                margin: EdgeInsets.only(top: 15),
                child: Center(
                  child: TextButton(
                    child: Text("Start"),
                    onPressed: () {
                      _showDialog(context);
                      _toggle();
                      status = false;
                    },
                  ),
                ),
              ),
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
