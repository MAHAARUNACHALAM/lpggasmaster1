import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/Search.dart';

var consumer;

class adduser extends StatefulWidget {
  final String name;
  final String Appartment;
  final String block;
  final String consumerno;
  final String cost;
  final String currentReading;
  final String amount;
  final String date;
  final String unitConsumed;
  // var addbill;

  adduser(this.name, this.Appartment, this.block, this.cost, this.consumerno,
      this.currentReading, this.amount, this.date, this.unitConsumed);

  @override
  _adduserState createState() => _adduserState();
}

class _adduserState extends State<adduser> {
  void _showButtonPressDialog(BuildContext context, String provider) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$provider Button Pressed!'),
      backgroundColor: Colors.black26,
      duration: Duration(milliseconds: 400),
    ));
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return consumer.add({
      'Name': widget.name,
      'Apartment Name': widget.Appartment,
      'Block': widget.block,
      'cost': widget.cost,
      'Consumer No ': widget.consumerno,
    }).then(
      (value) {
        FirebaseFirestore.instance
            .collection('CUSTOMER DATA')
            .doc(value.id)
            .collection('Bill Cycle')
            .add({
          'Amount': widget.amount,
          'Current Reading': widget.currentReading,
          'Date Of Reading': widget.date,
          'Unit Consumed': widget.unitConsumed
        });
        _showButtonPressDialog(context, 'User created');
      },
    ).catchError(
        (error) => _showButtonPressDialog(context, "User not Created: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SearchId(),
            ),
          );
          setState(() {
            consumer = FirebaseFirestore.instance.collection('CUSTOMER DATA');
          });
          addUser();

          // print('amount' + amount.toString());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (BuildContext context) => null,
          // );
        },
        child: Text('Create User'));
  }
}
