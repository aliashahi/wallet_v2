import 'package:flutter/material.dart';
import 'package:wallet_v2/screens/add_dialog.component.dart';
import 'package:wallet_v2/screens/cart.component.dart';
import 'package:wallet_v2/screens/chart.component.dart';

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
            backgroundImage:
                NetworkImage('https://wallpaperaccess.com/full/2213424.jpg'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: createAppBar(),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).backgroundColor,
                    Colors.grey[900]
                  ]),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  BarChartSample1(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: ListTile(
                        title: Text(
                      "Recent",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    )),
                  ),
                  // Text(
                  //   'You have pushed the button this many times:',
                  // ),
                  // Text(
                  //   '$_counter',
                  //   style: Theme.of(context).textTheme.headline4,
                  // ),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  TransactionCard(),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openDialog(context);
          },
          tooltip: 'new item +',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
