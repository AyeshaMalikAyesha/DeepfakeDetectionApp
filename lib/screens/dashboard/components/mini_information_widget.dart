import 'package:fake_vision/models/daily_info_model.dart';
import 'package:fake_vision/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key? key,
    required this.dailyData,
  }) : super(key: key);
  final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

int _value = 1;

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        gradient: navColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Icon(
                    widget.dailyData.icon,
                    color: widget.dailyData.color,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 1.0),
                  child: DropdownButton(
                    dropdownColor: blueColor,
                    icon: Icon(
                      Icons.more_vert,
                      size: 18,
                      color: whiteColor,
                    ),
                    underline: SizedBox(),
                    style: customTextStyle,
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "Daily",
                          style: customTextStyle,
                        ),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text(
                          "Weekly",
                          style: customTextStyle,
                        ),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("Monthly", style: customTextStyle),
                        value: 3,
                      ),
                    ],
                    onChanged: (int? value) {
                      setState(() {
                        _value = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.dailyData.title!,
                  style: customTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: LineChartWidget(
                    colors: widget.dailyData.colors,
                    spotsData: widget.dailyData.spots,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProgressLine(
              color: widget.dailyData.color!,
              percentage: widget.dailyData.percentage!,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.dailyData.volumeData}",
                  style: customTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    Key? key,
    required this.colors,
    required this.spotsData,
  }) : super(key: key);
  final List<Color>? colors;
  final List<FlSpot>? spotsData;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50,
          height: 30,
          child: LineChart(
            LineChartData(
                lineBarsData: [
                  LineChartBarData(
                      spots: spotsData,
                      belowBarData: BarAreaData(show: false),
                      aboveBarData: BarAreaData(show: false),
                      isCurved: true,
                      dotData: FlDotData(show: false),
                      colors: colors,
                      barWidth: 3),
                ],
                lineTouchData: LineTouchData(enabled: false),
                titlesData: FlTitlesData(show: false),
                axisTitleData: FlAxisTitleData(show: false),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false)),
          ),
        ),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
