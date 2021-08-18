import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/Dashboard.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/Screens/ViewBill.dart';
import 'package:lpggasmaster1/Screens/ViewHistory.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/hexColor.dart';

class GenerateBill extends StatefulWidget {
  GenerateBill({Key? key}) : super(key: key);

  @override
  _GenerateBillState createState() => _GenerateBillState();
}

class _GenerateBillState extends State<GenerateBill> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                'Genarate Bill',
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
        children: [
          Padding(padding: EdgeInsets.all(25)),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Connection Information',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(padding: EdgeInsets.all(30)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Consumer No:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100'))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Name:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100'))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Mobile No:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100'))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Address',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100'))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(40)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Payment Status:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100'))
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(
                  child: Text(
                    'Bill due date:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 20)),
                Container(child: Text('100')),
              ],
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
              Container(
                child: SizedBox(
                  width: 100,
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
                      'Back',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (BuildContext context) => Subcription(),
                          builder: (BuildContext context) => Dashboard(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                child: SizedBox(
                  width: 100,
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
                      'View Bill',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     // builder: (BuildContext context) => Subcription(),
                      //     builder: (BuildContext context) => ViewBill(10),
                      //   ),
                      // );
                    },
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                child: SizedBox(
                  width: 100,
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
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          // builder: (BuildContext context) => Subcription(),
                          builder: (BuildContext context) => ViewHistory(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
