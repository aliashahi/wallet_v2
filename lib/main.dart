import 'package:flutter/material.dart';
import 'package:wallet_v2/controller/data.service.dart';
import 'package:wallet_v2/screens/add_dialog.component.dart';
import 'package:wallet_v2/screens/cart.component.dart';
import 'package:wallet_v2/screens/bar_chart.component.dart';

import 'screens/pie_chart.component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet v2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(34, 37, 56, 1),
        backgroundColor: Color.fromRGBO(34, 37, 56, 1),
        accentColor: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> recentList = [];
  createAppBar() {
    return AppBar(
      toolbarHeight: 70,
      title: Text(
        'wallet'.toUpperCase(),
      ),
      leading: Icon(Icons.widgets),
      elevation: 0,
      actions: [
        Padding(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/default_avatar.jpg'),
          ),
        ),
      ],
    );
  }

  _deleteTransaction(int id) async {
    DataService dataService = new DataService();
    await dataService.deleteTransaction(id);
    _createList();
  }

  _createList() async {
    DataService dataService = new DataService();
    List<Transaction> s = await dataService.transactions();
    List<Widget> items = [];
    s.sort((Transaction a, Transaction b) => b.time.compareTo(a.time));
    s.forEach((element) {
      items.add(
        TransactionCard(
          transaction: element,
          onDelete: _deleteTransaction,
        ),
      );
    });
    setState(() {
      recentList = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _createList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: createAppBar(),
        body: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).backgroundColor,
                  Colors.cyan[800]
                ]),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: size.width - 20,
                        height: 300,
                        child: MyBarChart(),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: size.width - 20,
                        height: 300,
                        child: MyPieChart(),
                      )
                    ],
                  ),
                ),
                recentList.isEmpty ? Container() : ListHeader(title: 'Recent'),
                SizedBox(
                  height: 10,
                ),
                ...recentList,
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            handleDialog(context);
          },
          tooltip: 'new item +',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ListHeader extends StatelessWidget {
  final String title;
  const ListHeader({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: ListTile(
          title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white70,
        ),
      )),
    );
  }
}

void handleDialog(context) async {
  Transaction s = await openDialog(context);
  if (s != null) {
    DataService dataService = new DataService();
    await dataService.insertTransaction(s);
  }
}
