import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lpggasmaster1/DB.dart';

import '../hexColor.dart';
import '../main.dart';
import 'Camera.dart';
import 'Search.dart';
import 'login.dart';

class GasBillSystems extends StatefulWidget {
  GasBillSystems({Key? key}) : super(key: key);

  @override
  _GasBillSystemsState createState() => _GasBillSystemsState();
}

class _GasBillSystemsState extends State<GasBillSystems> {
  String? Date;
  double? reading;
  double? UnitConsumed;
  double? Amount;

  @override
  Widget build(BuildContext context) {
    unitConsumedcalculator(String Previous) {
      UnitConsumed = reading! - double.parse(Previous);
    }

    amountCalculator() {
      Amount = UnitConsumed! * 5;
    }

    return Scaffold(
      appBar: AppBar(
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
      body: FutureBuilder(
          future: profileData,
          builder: (context, AsyncSnapshot snapshot) {
            return SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Address:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            // '',
                            snapshot.data.docs[0]['Apartment Name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // TextFormField(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Consumer No:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            // '',
                            snapshot.data.docs[0]['Consumer No '],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // TextFormField(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Date Of Reading:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            DateFormat("dd-MM-yyyy").format(DateTime.now()),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // TextFormField(),
                        ],
                      ),
                    ),
                    StreamBuilder<DocumentSnapshot>(
                      stream: data,
                      builder: (context, AsyncSnapshot snapshot) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Starting Reading:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    snapshot.data['Current Reading'],
                                    // snapshot.data.docs[0]['Apartment Name'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  // TextFormField(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Ending Reading:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 150,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        // icon: Icon(Icons.person),
                                        labelText: 'Current Reading',
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                      ),
                                      // initialValue: (QRM != null) ? QRM : null,
                                      onFieldSubmitted: (value) {
                                        reading = double.parse(value);
                                        unitConsumedcalculator(
                                            snapshot.data['Current Reading']);
                                        amountCalculator();
                                      },
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TakePictureScreen(
                                                    camera: cameras.first),
                                          ),
                                        );
                                        setState(() {
                                          Date = DateTime.now().toString();
                                        });
                                        amountCalculator();
                                      },
                                      icon: Icon(Icons.camera_alt))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // UnitConsumed=snapshot.data['Current Reading']-reading,
                          Text(
                            'Unit Consumed:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),

                          Text(
                            (UnitConsumed == null)
                                ? '0'
                                : UnitConsumed.toString(),
                            // snapshot.data.docs[0]['Apartment Name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // TextFormField(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Amount:',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),

                          Text(
                            (Amount == null) ? '0' : Amount.toString(),
                            // snapshot.data.docs[0]['Apartment Name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          // TextFormField(),
                        ],
                      ),
                    ),
                    (Amount != null)
                        ? BillCycle(reading!.toString(), Amount!.toString(),
                            Date!, UnitConsumed!.toString())
                        : ElevatedButton(
                            child: Text('Generate Bill'),
                            onPressed: null,
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
