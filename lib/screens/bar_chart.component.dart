import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wallet_v2/controller/data.service.dart';

class MyBarChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyBarChartState();
}

class MyBarChartState extends State<MyBarChart> {
  final Duration animDuration = const Duration(milliseconds: 250);
  List<BarChartGroupData> data = [];
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    showingGroups();
    return AspectRatio(
      aspectRatio: 1.2,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    'Weekly Transactions',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // Text(
                  //   '99/08/01 to 99/09/30',
                  //   style: TextStyle(
                  //       color: Color(0xff379982),
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.ac_unit,
                    color: Colors.white70,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  showingGroups() async {
    DataService dataService = new DataService();
    List<Transaction> trans = await dataService.transactions();
    List<BarChartGroupData> bcg = [];
    int max = 0;
    trans.forEach((e) {
      if (e.amount > max) max = e.amount;
    });
    trans.forEach((Transaction element) {
      switch ((element.time.weekday + 1) % 7) {
        case 0:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 1, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 2, max));
          break;
        case 1:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 3, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 4, max));
          break;
        case 2:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 5, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 6, max));
          break;
        case 3:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 7, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 8, max));
          break;
        case 4:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 9, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 10, max));
          break;
        case 5:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 11, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 12, max));
          break;
        case 6:
          element.isIncome == 1
              ? bcg.add(
                  makeGroupData(element, 13, max, barColor: Colors.blueAccent))
              : bcg.add(makeGroupData(element, 14, max));
          break;
        default:
          break;
      }
    });
    this.data = bcg;
  }

  BarChartGroupData makeGroupData(Transaction t, int index, int max,
      {Color barColor = Colors.pink, double width = 10}) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          y: t.amount.toDouble(),
          colors: [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: max.toDouble() + 5,
            colors: [Theme.of(context).backgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: [],
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Saturday';
                  break;
                case 1:
                  weekDay = 'Sunday';
                  break;
                case 2:
                  weekDay = 'Monday';
                  break;
                case 3:
                  weekDay = 'Tuesday';
                  break;
                case 4:
                  weekDay = 'Wednesday';
                  break;
                case 5:
                  weekDay = 'Thursday';
                  break;
                case 6:
                  weekDay = 'Friday';
                  break;
              }
              return BarTooltipItem(weekDay + '\n' + (rod.y - 1).toString(),
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          ),
          margin: 10,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 1:
                return 'SAT\nincome';
              case 2:
                return 'SAT\ncost';
              case 3:
                return 'SUN\nincome';
              case 4:
                return 'SUN\ncost';
              case 5:
                return 'MON\nincome';
              case 6:
                return 'MON\ncost';
              case 7:
                return 'TUR\nincome';
              case 8:
                return 'TUR\ncost';
              case 9:
                return 'WED\nincome';
              case 10:
                return 'WED\ncost';
              case 11:
                return 'THU\nincome';
              case 12:
                return 'THU\nout';
              case 13:
                return 'FRI\nincome';
              case 14:
                return 'FRI\ncost';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: data ?? [],
    );
  }
}
