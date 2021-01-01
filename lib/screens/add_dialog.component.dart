import 'package:flutter/material.dart';
import 'package:wallet_v2/controller/data.service.dart';

Future<Transaction> openDialog(context) async {
  String enteredValue;
  String enteredTitle;
  bool isIncome = false;
  switch (await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 6,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey[800],
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.cyan[900], Colors.grey[800]],
                )),
            height: 280,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white12,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        enteredTitle = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Title like Shoping!!',
                        hintStyle: TextStyle(
                          color: Colors.white70.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white12,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        enteredValue = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Amount like 100\$',
                        hintStyle: TextStyle(
                          color: Colors.white70.withOpacity(0.5),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          onChanged: (value) {
                            isIncome = !isIncome;
                          },
                          value: isIncome,
                        ),
                        Text(
                          "its an income ?? ",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 1);
                        },
                        child: ClipRect(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.pink[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, 0);
                        },
                        child: ClipRect(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      })) {
    case 0:
      return null;
      break;
    case 1:
      if (enteredValue != null) {
        try {
          return new Transaction(
              amount: int.parse(enteredValue),
              isIncome: isIncome ? 1 : 0,
              time: DateTime.now(),
              title: enteredTitle);
        } catch (e) {
          return null;
        }
      }
      break;
    default:
      return null;
      break;
  }
}
