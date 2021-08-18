import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:lpggasmaster1/hexColor.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

var uid;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  // String email = " ", password = " ";
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Spacer(),
          Container(
              // alignment: Alignment.topCenter,
              // child: Image(image: AssetImage('assets/images/icon.png')),
              ),
          Column(
            children: [
              Container(
                // alignment: Alignment.topCenter,
                child: Image(image: AssetImage('assets/images/icon.png')),
              ),
              Container(
                child: Text(
                  'LPG Gas Meter',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              // Padding(padding: EdgeInsets.all(25)),
              Container(
                  child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: 'User id',
                  ),
                  onSaved: (String? value) {
                    // email = value!.trim();
                    // This optional block of code can be used to run
                    // code when the user saves the form.
                  },
                  // validator: (String? value) {
                  //   return (value != null && value.contains('@'))
                  //       ? 'Do not use the @ char.'
                  //       : null;
                  // },
                ),
              )),
              Container(
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: password,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Password',
                    ),
                    onSaved: (String? value) {
                      // password = value!.trim();
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                    },
                    // validator: (String? value) {
                    //   return (value != null && value.contains('@'))
                    //       ? 'Do not use the @ char.'
                    //       : null;
                    // },
                  ),
                ),
              ),
              // Padding(padding: EdgeInsets.all(20)),
              Container(
                child: SizedBox(
                  width: 250,
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
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      try {
                        auth
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text)
                            .then(
                          (_) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (BuildContext context) => Subcription(),
                                builder: (BuildContext context) => SearchId(),
                              ),
                            );
                          },
                        );
                      } on FirebaseAuthException catch (e) {}
                    },
                    // onPressed: () async {
                    //   try {
                    //     await FirebaseAuth.instance
                    //         .signInWithEmailAndPassword(
                    //             email: userName.text, password: password.text)
                    //         .then((value) {
                    //       uid = value.user!.uid;
                    //       // Navigator.of(context).pushReplacement(
                    //       //     MaterialPageRoute(
                    //       //         builder: (context) => SearchId()));
                    //       Fluttertoast.showToast(
                    //           msg: 'Signed in as ${userName.text}');
                    //     });
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'user-not-found') {
                    //     Fluttertoast.showToast(
                    //         msg: 'No user found for that email.');
                    //   } else if (e.code == 'wrong-password') {
                    //     Fluttertoast.showToast(
                    //         msg: 'Wrong password provided for that user.');
                    //   }
                    // }
                    // },
                  ),
                ),
              ),
            ],
          ),
          // Padding(padding: EdgeInsets.all(2.5)),
          // Spacer(),

          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: 100,
                child: Image(image: AssetImage('assets/images/Atsuya.png'))),
          )
          // Positioned(
          //   child: SizedBox(
          //     width: 100,
          //     child: Image(image: AssetImage('assets/images/Atsuya.png')),
          //   ),
          // ),
        ],
      ),
    );
  }
}
