import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/Dashboard.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/clipper/clipper.dart';
import 'package:lpggasmaster1/hexColor.dart';

class ViewBill extends StatefulWidget {
  dynamic amount;

  ViewBill({Key? key, this.amount}) : super(key: key);

  // ViewBill(amount=this.Amount);

  @override
  _ViewBillState createState() => _ViewBillState(amount);
}

class _ViewBillState extends State<ViewBill> {
  // String get Amount => amount;

  // get amount => amount;

  // get Amount => Amount;

  dynamic Amount;
  _ViewBillState(this.Amount);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('GenerateBill'),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10)),
            IconButton(
              alignment: Alignment.topLeft,
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SearchId(),
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'View Bill',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
        leadingWidth: 100,
        toolbarHeight: 80,
        backgroundColor: b,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'logout',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // builder: (BuildContext context) => Subcription(),
                  builder: (BuildContext context) => LoginScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 35)),
          Center(
            child: ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(18.0)),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(15)),
                    Container(
                      child: Text(
                        'Total Bill Amount',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    DottedLine(
                      dashLength: 10,
                    ),
                    Padding(padding: EdgeInsets.all(15)),
                    Container(
                      child: Text(
                        // 'hi',
                        Amount.toString(),
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Padding(padding: EdgeInsets.all(50)),
                    // Spacer(),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.blue[100],
                    //       borderRadius: BorderRadius.circular(18.0)),
                    //   child: Text('Hi'),
                    // )
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            // alignment: Alignment.topLeft,
            width: 350,
            height: 250,
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(18.0)),
            padding: EdgeInsets.all(15),
            child: Image(
              image: AssetImage('assets/images/UPI.jpeg'),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: 100,
                  child: Image(image: AssetImage('assets/images/Atsuya.png'))),
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   child: SizedBox(
              //     width: 125,
              //     child: ElevatedButton(
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(18.0),
              //           ),
              //         ),
              //         backgroundColor: MaterialStateProperty.all<Color>(b),
              //       ),
              //       child: Text(
              //         'Back',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             // builder: (BuildContext context) => Subcription(),
              //             builder: (BuildContext context) => Dashboard(),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                child: SizedBox(
                  width: 125,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(b),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (BuildContext context) => Subcription(),
                          builder: (BuildContext context) => SearchId(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
            ],
          ),
        ],
      ),
    );
  }
}
