// import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:lpggasmaster1/Screens/Camera.dart';
import 'package:lpggasmaster1/Screens/GasBillSystem.dart';
import 'package:lpggasmaster1/Screens/GenerateBill.dart';
import 'package:lpggasmaster1/Screens/MeterScanner.dart';
import 'package:lpggasmaster1/Screens/QrScan.dart';
import 'package:lpggasmaster1/Screens/ViewBill.dart';
import 'package:lpggasmaster1/Screens/ViewHistory.dart';
import 'package:lpggasmaster1/Screens/imageCropper.dart';
import 'package:lpggasmaster1/hexColor.dart';
import 'package:lpggasmaster1/main.dart';

import 'Search.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // @override
  // void initState() {
  //   super.initState();
  //   profileData = getdata();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // QRM = '100';
    // profileData = FirebaseFirestore.instance
    //     .collection('CUSTOMER DATA')
    //     .where('Consumer No ', isEqualTo: QRM)
    //     .snapshots()
    //     .first;
    // print(QRM);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(
      fontFamily: "LeagueSpartan-Bold",
      fontSize: 14,
      // color: Color.fromRGBO(63, 63, 63, 1),
      color: Colors.black87,
    );
    RaisedButton button = RaisedButton(
      onPressed: () {
        setState(() {});
      },
      child: Text('Refresh'),
    );

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: size.height * .5,
          decoration: BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/images/DashTop.png')),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child:
                          Image(image: AssetImage('assets/images/iconw.png')),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'LPG Gas Meter',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    // Padding(padding: EdgeInsets.all(5)),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Good Morning!',
                        style: TextStyle(
                            fontSize: 15,
                            // fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),

                    // Padding(padding: EdgeInsets.all(5)),

                    FutureBuilder(
                        future: profileData,
                        builder: (context, AsyncSnapshot snapshot) {
                          return snapshot.hasData
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    snapshot.data.docs[0]['Name'],
                                    // 'Ramesh',
                                    // snapshot.data!.docs[0],

                                    // snapshot.data!.docs[0][customerId].toString(),

                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(),
                                );
                        }),

                    // StreamBuilder<DocumentSnapshot>(
                    //     stream: data,
                    //     builder: (context, snapshot) {
                    //       return snapshot.hasData
                    //           ? Container(
                    //               alignment: Alignment.center,
                    //               child: Text(
                    //                 // snapshot.data.docs[0]['Name'],
                    //                 snapshot.data!['Name'],
                    //                 // 'Ramesh',
                    //                 // snapshot.data!.docs[0],

                    //                 // snapshot.data!.docs[0][customerId].toString(),

                    //                 style: TextStyle(
                    //                     fontSize: 20,
                    //                     fontWeight: FontWeight.bold,
                    //                     color: Colors.white),
                    //               ),
                    //             )
                    //           : Center(
                    //               child: CircularProgressIndicator(),
                    //             );
                    //     }),
                  ],
                ),
                Padding(padding: EdgeInsets.all(15)),
                Container(
                  child: Text(
                    'Gas Bill System',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                Expanded(
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TakePictureScreen(camera: cameras.first),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          elevation: 0,
                          color: Colors.purple[50],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/D1.png'),
                                height: 128,
                              ),
                              Text(
                                '5 Kcal/kg',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  // cropper(camera: cameras.first),
                                  GasBillSystems(
                                ocrReading: " ",
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          elevation: 0,
                          color: gr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/QR.png'),
                                height: 128,
                              ),
                              Text(
                                'Generate Bill',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ViewHistory(),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          elevation: 0,
                          color: gr,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/History.png'),
                                height: 128,
                              ),
                              Text(
                                'View History',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // print('cycleUpdate' + QRM.toString());
                          // getbilldata(QRM);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ViewBill(amount: 100),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          elevation: 0,
                          color: lb,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/images/Usage.png'),
                                height: 128,
                              ),
                              Text(
                                'Gas Usage',
                                style: cardTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      width: 100,
                      child:
                          Image(image: AssetImage('assets/images/Atsuya.png'))),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
