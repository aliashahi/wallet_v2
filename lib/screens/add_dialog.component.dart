import 'package:flutter/material.dart';

Future<void> openDialog(context) async {
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
            height: 190,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white12,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
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
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'like 10000.0000\$',
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
      // Let's go.
      // ...
      break;
    case 1:
      // ...
      break;
  }
}
