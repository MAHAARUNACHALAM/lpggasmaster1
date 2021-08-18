// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_login/flutter_login.dart';

// import 'users.dart';

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }

//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }

// Color myHexColor = HexColor("#25497F");
// Color myHexColor1 = HexColor("#427F00");
// Color myHexColor2 = HexColor("#FFDB8C");

// class LoginScreen extends StatelessWidget {
//   Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
//   Future<String> _loginUser(LoginData data) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(data.name)) {
//         return 'Username not exists';
//       }
//       if (mockUsers[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return NullThrownError();
//     });
//   }

//   Future<String> _recoverPassword(String name) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(name)) {
//         return 'Username not exists';
//       }
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final inputBorder = BorderRadius.vertical(
//       bottom: Radius.circular(10.0),
//       top: Radius.circular(20.0),
//     );

//     return FlutterLogin(
//       title: 'LPG Gas Meter',
//       logo: 'assets/images/icon.png',
//       onLogin: (loginData) {
//         print('Login info');
//         print('Name: ${loginData.name}');
//         print('Password: ${loginData.password}');
//         return _loginUser(loginData);
//       },
//       onSignup: (_) => Future(null),
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => null,
//         ));
//       },
//       onRecoverPassword: (_) => Future(null),
//       theme: LoginTheme(
//         primaryColor: Colors.white,
//         accentColor: Colors.blue[100],
//         errorColor: Colors.deepOrange,
//         titleStyle: TextStyle(
//           color: myHexColor2,
//           fontFamily: 'Arial',
//           letterSpacing: 4,
//           // backgroundColor: myHexColor,
//         ),
//         bodyStyle: TextStyle(
//           fontStyle: FontStyle.italic,
//           decoration: TextDecoration.underline,
//         ),
//         textFieldStyle: TextStyle(
//           color: myHexColor,
//           shadows: [Shadow(color: Colors.orange, blurRadius: 2)],
//         ),
//         buttonStyle: TextStyle(
//           fontWeight: FontWeight.w800,
//           color: Colors.yellow,
//         ),
//         cardTheme: CardTheme(
//           color: myHexColor2,
//           elevation: 5,
//           margin: EdgeInsets.only(top: 15),
//           shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.circular(100.0)),
//         ),
//         inputTheme: InputDecorationTheme(
//           filled: true,
//           fillColor: Colors.purple.withOpacity(.1),
//           contentPadding: EdgeInsets.zero,
//           errorStyle: TextStyle(
//             backgroundColor: Colors.orange,
//             color: Colors.white,
//           ),
//           labelStyle: TextStyle(fontSize: 12),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
//             borderRadius: inputBorder,
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
//             borderRadius: inputBorder,
//           ),
//           errorBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.red.shade700, width: 7),
//             borderRadius: inputBorder,
//           ),
//           focusedErrorBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.red.shade400, width: 8),
//             borderRadius: inputBorder,
//           ),
//           disabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey, width: 5),
//             borderRadius: inputBorder,
//           ),
//         ),
//         buttonTheme: LoginButtonTheme(
//           splashColor: Colors.purple,
//           backgroundColor: Colors.pinkAccent,
//           highlightColor: Colors.lightGreen,
//           elevation: 9.0,
//           highlightElevation: 6.0,
//           shape: BeveledRectangleBorder(
//             borderRadius: BorderRadius.circular(3),
//           ),
//           // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//           // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//           // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//         ),
//       ),
//     );
//   }
// }
