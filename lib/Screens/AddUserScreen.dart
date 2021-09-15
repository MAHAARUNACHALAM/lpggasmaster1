import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/AddUserDb.dart';

import '../hexColor.dart';
import 'Search.dart';
import 'login.dart';

const _chars = '1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class AddUserScreen extends StatefulWidget {
  AddUserScreen({Key? key}) : super(key: key);

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

String? PreviousReading;

class _AddUserScreenState extends State<AddUserScreen> {
  String? name;
  String? Appartment;
  String? block;
  String? consumerno;
  String? cost;
  String? currentReading;
  String? amount;
  String? date;
  String? unitConsumed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                  'Add User',
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
        body: Wrap(
          runSpacing: 25,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Padding(padding: EdgeInsets.only(right: 50)),
                  Expanded(
                    child: TextFormField(
                      scrollController: ScrollController(),
                      style: TextStyle(fontSize: 20),
                      onFieldSubmitted: (value) {
                        setState(() {
                          name = value;
                        });
                      },
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
                    'Appartment:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      scrollController: ScrollController(),
                      style: TextStyle(fontSize: 20),
                      onFieldSubmitted: (value) {
                        setState(() {
                          Appartment = value;
                        });
                      },
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
                    'Block:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      scrollController: ScrollController(),
                      style: TextStyle(fontSize: 20),
                      onFieldSubmitted: (value) {
                        setState(() {
                          block = value;
                        });
                      },
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
                    'Rate/Unit:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Expanded(
                    child: TextFormField(
                      // keyboardType: TextInputType.number,
                      scrollController: ScrollController(),
                      style: TextStyle(fontSize: 20),
                      onFieldSubmitted: (value) {
                        setState(() {
                          consumerno = getRandomString(2);
                          currentReading = 0.toString();
                          amount = 0.toString();
                          date = DateTime.now().toString();
                          unitConsumed = 0.toString();
                          cost = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            (cost == null ||
                    name == null ||
                    Appartment == null ||
                    block == null)
                ? Container(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: null, child: Text('Add User')))
                : Container(
                    alignment: Alignment.center,
                    child: adduser(
                        name!,
                        Appartment!,
                        block!,
                        cost!,
                        consumerno!,
                        currentReading!,
                        amount!,
                        date!,
                        unitConsumed!),
                  ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SizedBox(
            //       width: 100,
            //       child: Image(image: AssetImage('assets/images/Atsuya.png'))),
            // )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.white,
            child: Container(
                height: 50,
                child: Image(image: AssetImage('assets/images/Atsuya.png'))))
        // BottomAppBar(
        //     child: ImageIcon(
        //   AssetImage('assets/images/Atsuya.png'),
        //   size: 50,
        //   color: Colors.blue,
        // )),
        );
  }
}
