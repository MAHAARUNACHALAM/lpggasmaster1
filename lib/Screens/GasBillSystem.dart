import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lpggasmaster1/DB.dart';

import '../hexColor.dart';
import '../main.dart';
import 'Camera.dart';
import 'Search.dart';
import 'imageCropper.dart';
import 'login.dart';

class GasBillSystems extends StatefulWidget {
  String ocrReading;
  GasBillSystems({Key? key, required this.ocrReading}) : super(key: key);

  @override
  _GasBillSystemsState createState() => _GasBillSystemsState();
}

String? PreviousReading;

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

    amountCalculator(cost) {
      Amount = UnitConsumed! * int.parse(cost);
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
              child: Wrap(
                runSpacing: 20,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Address:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Padding(padding: EdgeInsets.only(right: 50)),
                        Expanded(
                          child: Text(
                            // '',
                            snapshot.data.docs[0]['Apartment Name'],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        // TextFormField(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rate/Unit:',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          // '',
                          snapshot.data.docs[0]['cost'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        // TextFormField(),
                      ],
                    ),
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('CUSTOMER DATA')
                        .doc(customerId)
                        .collection('Bill Cycle')
                        .doc(bill)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return (snapshot.hasData)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Previous Reading:',
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
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Current Reading:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 120,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                              // icon: Icon(Icons.person),
                                              // labelText: 'Current Reading',
                                              // labelStyle: TextStyle(
                                              //     color: Colors.black,
                                              //     fontSize: 25),
                                              ),
                                          scrollController: ScrollController(),
                                          style: TextStyle(fontSize: 20),
                                          initialValue:
                                              (widget.ocrReading != null)
                                                  ? widget.ocrReading
                                                  : null,
                                          onFieldSubmitted: (value) {
                                            widget.ocrReading = value;
                                            reading =
                                                double.parse(widget.ocrReading);
                                            setState(() {
                                              PreviousReading = snapshot
                                                  .data['Current Reading'];
                                            });
                                            // (snapshot.data['Current Reading'].hasdata)
                                            //     ? unitConsumedcalculator(
                                            //         snapshot.data['Current Reading'])
                                            //     : null;
                                            // amountCalculator();
                                          },
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        cropper(
                                                            camera:
                                                                cameras.first),
                                              ),
                                            );
                                            // setState(() {
                                            //   Date = DateTime.now().toString();
                                            // });
                                            // amountCalculator();
                                          },
                                          icon: Icon(Icons.camera_alt)),
                                      // IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(Icons.local_atm_outlined))
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: Text('Calculate Amount'),
                        onPressed: () {
                          unitConsumedcalculator(PreviousReading!);

                          amountCalculator(snapshot.data.docs[0]['cost']);
                          setState(() {
                            Date = DateTime.now().toString();
                          });
                        },
                      ),
                      (Amount != null)
                          ? BillCycle(reading!.toString(), Amount!.toString(),
                              Date!, UnitConsumed!.toString())
                          : ElevatedButton(
                              child: Text('Generate Bill'), onPressed: null),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                        width: 100,
                        child: Image(
                            image: AssetImage('assets/images/Atsuya.png'))),
                  )
                ],
              ),
            );
          }),
    );
  }
}
