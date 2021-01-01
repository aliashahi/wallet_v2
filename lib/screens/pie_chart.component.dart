import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wallet_v2/controller/data.service.dart';
import 'package:wallet_v2/controller/price.pipe.dart';

class MyPieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyPieChartState();
}

class MyPieChartState extends State<MyPieChart> {
  int touchedIndex;
  int _cost = 0;
  int _income = 0;
  int _balance = 0;

  @override
  Widget build(BuildContext context) {
    _getData();
    return AspectRatio(
      aspectRatio: 1.2,
      child: Card(
        color: Theme.of(context).backgroundColor,
        child: Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    }),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 3,
                    centerSpaceRadius: 50,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Colors.pink,
                  text: 'Costs',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.lightBlue,
                  text: 'Incomes',
                  isSquare: false,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d388),
                  text: 'Balance',
                  isSquare: false,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  _getData() async {
    DataService dataService = new DataService();
    List<Transaction> trans = await dataService.transactions();
    int cost = 0;
    int income = 0;
    int balance = 0;
    trans.forEach((e) {
      if (e.isIncome == 1) {
        income += e.amount;
        balance += e.amount;
      } else {
        cost += e.amount;
        balance -= e.amount;
      }
    });
    this._balance = balance;
    this._income = income;
    this._cost = cost;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16 : 12;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.pink,
            value: _cost.toDouble(),
            title: priceConvertor(_cost) + '\$',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.lightBlue,
            value: _income.toDouble(),
            title: priceConvertor(_income) + '\$',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: _balance.toDouble(),
            title: priceConvertor(_balance) + '\$',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
