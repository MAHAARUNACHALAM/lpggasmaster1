import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/Screens/ViewBill.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/Screens/prelogin.dart';
import 'package:lpggasmaster1/hexColor.dart';

String? Qrresult;
FirebaseFirestore firestore = FirebaseFirestore.instance;
// CollectionReference customers =
//     FirebaseFirestore.instance.collection('CUSTOMER DATA');
String? customerId;

// String customerId = '0DcJHrXTeX8ZwYL2GyNQ';

var profileData;
var billData;
var bill;
var data;
var cycleUpdate;

// = FirebaseFirestore.instance
//     .collection('CUSTOMER DATA')
//     .where('Consumer No ', isEqualTo: QRM)
//     .snapshots()
//     .first;
// var data = FirebaseFirestore.instance
//     .collection('CUSTOMER DATA')
//     .doc(customerId)
//     .snapshots();

// Future<DocumentSnapshot<Map<String, dynamic>>> docref = FirebSaseFirestore.instance
//     .collection('CUSTOMER DATA')
//     .doc(customerId)
//     .get();

// CollectionReference gBill = FirebaseFirestore.instance
//     .collection('CUSTOMER DATA')
//     .doc(customerId)
//     .collection('Bill Cycle');
var cycleUpdate1;

class BillCycle extends StatefulWidget {
  final String currentReading;
  final String amount;
  final String date;
  final String unitConsumed;
  // var addbill;

  BillCycle(this.currentReading, this.amount, this.date, this.unitConsumed);

  @override
  _BillCycleState createState() => _BillCycleState();
}

class _BillCycleState extends State<BillCycle> {
  get amount => amount;

  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var cardTextStyle = TextStyle(
      fontFamily: "LeagueSpartan-Bold",
      fontSize: 14,
      // color: Color.fromRGBO(63, 63, 63, 1),
      color: Colors.black87,
    );

    Future<void> addBill() {
      // Call the user's CollectionReference to add a new user
      return cycleUpdate1
          .add({
            'Amount': widget.amount,
            'Current Reading': widget.currentReading,
            'Date Of Reading': widget.date,
            'Unit Consumed': widget.unitConsumed
          })
          .then((value) => _showButtonPressDialog(context, 'Bill Generated'))
          .catchError((error) => _showButtonPressDialog(
              context, "Failed to Generate Bil: $error"));
    }

    // throw ('Successful');

    return ElevatedButton(
        onPressed: () {
          setState(() {
            cycleUpdate1 = FirebaseFirestore.instance
                .collection('CUSTOMER DATA')
                .doc(customerId)
                .collection('Bill Cycle');
          });
          addBill();
          // print('amount' + amount.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ViewBill(
                      amount: double.parse(widget.amount),
                    )),
          );
        },
        child: Text('Generate Bill'));
  }
}

getCustomerdata(String? a) {
  print(a);
  FirebaseFirestore.instance
      .collection('CUSTOMER DATA')
      .where('Consumer No ', isEqualTo: a)
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((c) {
              customerId = c.reference.id;
              print("documentID---- " + customerId!);
            }),
          });
  // getdata(customerId);
  // getbilldata(customerId);

  // print("BillData" + billData);
}

getdata(String? a) {
  print('object' + a!);
  profileData = FirebaseFirestore.instance
      .collection('CUSTOMER DATA')
      .where('Consumer No ', isEqualTo: a)
      .snapshots()
      .first;
  // getCustomerdata(QRM);

  // print("TAG" + profileData.toString());
  // print(QRM);
}

getbilldata(String? a) {
  print('Number' + a!);
  // getCustomerdata(a);
  FirebaseFirestore.instance
      .collection('CUSTOMER DATA')
      .where('Consumer No ', isEqualTo: a)
      .get()
      .then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((c) {
              customerId = c.reference.id;
              billData = FirebaseFirestore.instance
                  .collection('CUSTOMER DATA')
                  .doc(customerId)
                  .collection('Bill Cycle')
                  .orderBy('Date Of Reading')
                  // .orderBy('Date Of Reading',descending: )
                  .limitToLast(1)
                  .get()
                  .then((QuerySnapshot snapshot) => {
                        snapshot.docs.forEach((c) {
                          bill = c.reference.id;
                          print("BillID---- " + bill);
                          data = FirebaseFirestore.instance
                              .collection('CUSTOMER DATA')
                              .doc(customerId)
                              .collection('Bill Cycle')
                              .doc(bill)
                              .snapshots();
                        }),
                      });

              // print("documentID---- " + billData!);
            }),
          });

  // print('Customer id' + customerId!);

  // print('Bill data' + );
}

// addBill(var a, String? amount, String? currentReading, String? dat,
//     String? unitConsumed) {
//   // Call the user's CollectionReference to add a new user
//   return a
//       .add({
//         'Amount': amount,
//         'Current Reading': currentReading,
//         'Date Of Reading': dat,
//         'Unit Consumed': unitConsumed
//       })
//       .then((value) => print("Bill Generated"))
//       .catchError((error) => print("Failed to Generate Bil: $error"));
// }

void signOut() {
  FirebaseAuth.instance.signOut();

  //print('$user');
  runApp(new MaterialApp(
    home: PreLogin(),
  ));
}
