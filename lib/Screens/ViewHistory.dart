import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:lpggasmaster1/Screens/Dashboard.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/hexColor.dart';

class ViewHistory extends StatefulWidget {
  ViewHistory({Key? key}) : super(key: key);

  @override
  _ViewHistory createState() => _ViewHistory();
}

class _ViewHistory extends State<ViewHistory> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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
                'View History',
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
              signOut();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     // builder: (BuildContext context) => Subcription(),
              //     builder: (BuildContext context) => LoginScreen(),
              //   ),
              // );
            },
          )
        ],
      ),
      body: FutureBuilder(
          future: profileData,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? Column(
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
                            Container(
                                child: Text(
                              snapshot.data.docs[0]['Consumer No '],
                            ))
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
                            Container(
                                child: Text(snapshot.data.docs[0]['Name']))
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
                      Row(
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
                          Container(
                              child:
                                  Text(snapshot.data.docs[0]['Apartment Name']))
                        ],
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
                                'Bill due date in:',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 20)),
                            Container(child: Text('10 days')),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              width: 100,
                              child: Image(
                                  image:
                                      AssetImage('assets/images/Atsuya.png'))),
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
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(b),
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
                                      builder: (BuildContext context) =>
                                          Dashboard(),
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
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(b),
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
                                      builder: (BuildContext context) =>
                                          Dashboard(),
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
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}
