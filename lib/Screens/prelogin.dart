import 'package:flutter/material.dart';
import 'package:lpggasmaster1/Screens/login.dart';
import 'package:lpggasmaster1/hexColor.dart';

class PreLogin extends StatefulWidget {
  PreLogin({Key? key}) : super(key: key);

  @override
  _PreLoginState createState() => _PreLoginState();
}

class _PreLoginState extends State<PreLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              // alignment: Alignment.topCenter,
              // child: Image(image: AssetImage('assets/images/icon.png')),
              ),
          // Spacer(),
          Column(
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
              Padding(padding: EdgeInsets.all(35)),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // builder: (BuildContext context) => Subcription(),
                        builder: (BuildContext context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              )),
              Padding(padding: EdgeInsets.all(2.5)),
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
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: null,
                  ),
                ),
              ),
            ],
          ),
          // Spacer(),
          // Padding(padding: EdgeInsets.only(top: 150)),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                width: 100,
                child: Image(image: AssetImage('assets/images/Atsuya.png'))),
          )
        ],
      ),
    );
  }
}
