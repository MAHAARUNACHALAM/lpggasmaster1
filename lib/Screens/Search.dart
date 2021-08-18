import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:lpggasmaster1/Screens/Dashboard.dart';
import 'package:lpggasmaster1/Screens/QrScan.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/hexColor.dart';

class SearchId extends StatefulWidget {
  SearchId({Key? key}) : super(key: key);

  @override
  _SearchIdState createState() => _SearchIdState();
}

String? QRM;

class _SearchIdState extends State<SearchId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image(image: AssetImage('assets/images/icon.png')),
                ),
                Container(
                  child: Text(
                    'LPG Gas Meter',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Consumer No',
                    ),
                    initialValue: (QRM != null) ? QRM : null,
                    onFieldSubmitted: (String value) {
                      QRM = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(b),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  QRViewExample(),
                            ),
                          );

                          setState(() {
                            QRM = Qrresult;
                            Qrresult = null;
                          });
                        },
                        icon: Icon(Icons.camera_alt_outlined),
                        label: Text('Scan Qr'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(b),
                        ),
                        onPressed: () {
                          getbilldata(QRM);
                          getdata(QRM);

                          // // getCustomerdata(QRM);
                          // // getbilldata(customerId);
                          // // print(collectionStream);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Dashboard(),
                            ),
                          );
                        },
                        // icon: Icon(Icons.camera_alt_outlined),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text('Next'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Container(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/images/Atsuya.png',
                // height: 20,
                width: 100,
              ),
            ),
          ]),
    );
  }
}

// class SearchId extends StatefulWidget {
//   SearchId({Key? key}) : super(key: key);

//   @override
//   _SearchIdState createState() => _SearchIdState();
// }

// class _SearchIdState extends State<SearchId> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
//       body: Column(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           // Padding(
//           //   padding: EdgeInsets.all(20),
//           // ),
//           Column(
//             children: [
              // Container(
              //   alignment: Alignment.center,
              //   child: Image(image: AssetImage('assets/images/icon.png')),
              // ),
              // Container(
              //   child: Text(
              //     'LPG Gas Meter',
              //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              //   ),
              // ),
//               // Padding(padding: EdgeInsets.all(20)),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   icon: Icon(Icons.person),
//                   labelText: 'Search User id',
//                 ),
//                 onSaved: (String? value) {
//                   // This optional block of code can be used to run
//                   // code when the user saves the form.
//                 },
//                 // validator: (String? value) {
//                 //   return (value != null && value.contains('@'))
//                 //       ? 'Do not use the @ char.'
//                 //       : null;
//                 // },
//               ),
//               // Padding(padding: EdgeInsets.all(5)),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     icon: Icon(Icons.person),
              //     labelText: 'Choose Appartment',
              //   ),
              //   onSaved: (String? value) {
              //     // This optional block of code can be used to run
              //     // code when the user saves the form.
              //   },
              //   // validator: (String? value) {
              //   //   return (value != null && value.contains('@'))
              //   //       ? 'Do not use the @ char.'
              //   //       : null;
              //   // },
              // ),
//               // Padding(padding: EdgeInsets.all(5)),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   icon: Icon(Icons.person),
//                   labelText: 'Location',
//                 ),
//                 onSaved: (String? value) {
//                   // This optional block of code can be used to run
//                   // code when the user saves the form.
//                 },
//                 // validator: (String? value) {
//                 //   return (value != null && value.contains('@'))
//                 //       ? 'Do not use the @ char.'
//                 //       : null;
//                 // },
//               ),
//               // Padding(padding: EdgeInsets.all(25)),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//                 // Padding(padding: EdgeInsets.all(35)),
//                 ElevatedButton(
                  // style: ButtonStyle(
                  //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //     RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //     ),
                  //   ),
                  //   backgroundColor: MaterialStateProperty.all<Color>(b),
                  // ),
//                   child: Padding(
                    // padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       'Back',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         // builder: (BuildContext context) => Subcription(),
//                         builder: (BuildContext context) => LoginScreen(),
//                       ),
//                     );
//                   },
//                 ),
//                 // Padding(padding: EdgeInsets.all(20)),
//                 ElevatedButton(
//                   style: ButtonStyle(
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(18.0),
//                       ),
//                     ),
//                     backgroundColor: MaterialStateProperty.all<Color>(b),
//                   ),
//                   child: Text(
//                     'Next',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         // builder: (BuildContext context) => Subcription(),
//                         builder: (BuildContext context) => Dashboard(),
//                       ),
//                     );
//                   },
//                 ),
//               ]),
//             ],
//           ),
//           // Spacer(),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Image.asset(
          //     'assets/images/Atsuya.png',
          //     // height: 20,
          //     width: 100,
          //   ),
          // ),
//         ],
//       ),
//     );
//   }
// }
