import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:lpggasmaster1/Screens/Search.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildQrView(context),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return ((Qrresult == null)
        ? (QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 50,
                borderWidth: 10,
                cutOutSize: scanArea),
          ))
        : SearchId());
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        // result = scanData;
        Qrresult = scanData.code;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// class HomePage extends StatefulWidget {
//   @override
//   HomePageState createState() {
//     return new HomePageState();
//   }
// }

// class HomePageState extends State<HomePage> {
//   String result = "HI ";
//   String qrResult = "How are you";

  // Future _scanQR() async {
//     try {
//       // qrResult = FlutterBarcodeScanner.scanBarcode(
//       //     '#ff666', "cancel", true, ScanMode.QR) as String;
//       ScanResult qrResult = await BarcodeScanner.scan();
//       setState(() {
//         result = qrResult.rawContent;
//       });
//     } on PlatformException catch (ex) {
//       if (ex.code == BarcodeScanner.cameraAccessDenied) {
//         setState(() {
//           result = "Camera permission was denied";
//         });
//       } else {
//         setState(() {
//           result = "Unknown Error $ex";
//         });
//       }
//     } on FormatException {
//       setState(() {
//         result = "You pressed the back button before scanning anything";
//       });
//     } catch (ex) {
      // setState(() {
      //   result = "Unknown Error $ex";
      // });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("QR Scanner"),
//       ),
//       body: Center(
//         child: Text(
//           result,
//           style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         icon: Icon(Icons.camera_alt),
//         label: Text("Scan"),
//         onPressed: _scanQR,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class ScanScreen extends StatefulWidget {
//   @override
//   _ScanState createState() => new _ScanState();
// }

// class _ScanState extends State<ScanScreen> {
//   String barcode = "";

//   @override
//   initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: new AppBar(
//           title: new Text('QR Code Scanner'),
//         ),
//         body: new Center(
//           child: new Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: RaisedButton(
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     splashColor: Colors.blueGrey,
//                     onPressed: scan,
//                     child: const Text('START CAMERA SCAN')),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                 child: Text(
//                   barcode,
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }

//   // Future scan() async {
//   //   try {
//   //     String barcode = await BarcodeScanner.scan();
//   //     setState(() => this.barcode = barcode);
//   //   } on PlatformException catch (e) {
//   //     if (e.code == BarcodeScanner.CameraAccessDenied) {
//   //       setState(() {
//   //         this.barcode = 'The user did not grant the camera permission!';
//   //       });
//   //     } else {
//   //       setState(() => this.barcode = 'Unknown error: $e');
//   //     }
//   //   } on FormatException {
//   //     setState(() => this.barcode =
//   //         'null (User returned using the "back"-button before scanning anything. Result)');
//   //   } catch (e) {
//   //     setState(() => this.barcode = 'Unknown error: $e');
//   //   }
//   // }

//   Future scan() async {
//     try {
//       String barcode = await BarcodeScanner.cameraAccessDenied;
//       setState(() => this.barcode = barcode);
//     } on PlatformException catch (e) {
//       if (e.code == BarcodeScanner.cameraAccessDenied) {
//         setState(() {
//           this.barcode = 'The user did not grant the camera permission!';
//         });
//       } else {
//         setState(() => this.barcode = 'Unknown error: $e');
//       }
//     } on FormatException {
//       setState(() => this.barcode =
//           'null (User returned using the "back"-button before scanning anything. Result)');
//     } catch (e) {
//       setState(() => this.barcode = 'Unknown error: $e');
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:lpggasmeter/Widget/button_widget.dart';

// import '../main.dart';

// class QRScanPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _QRScanPageState();
// }

// class _QRScanPageState extends State<QRScanPage> {
//   String qrCode = 'Unknown';

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(
//           title: Text('QRSCAN'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Scan Result',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.white54,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '$qrCode',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 72),
//               ButtonWidget(
//                 text: 'Start QR scan',
//                 onClicked: () => scanQRCode(),
//               ),
//             ],
//           ),
//         ),
//       );

//   Future<void> scanQRCode() async {
//     try {
//       final qrCode = await FlutterBarcodeScanner.scanBarcode(
//         '#ff6666',
//         'Cancel',
//         true,
//         ScanMode.QR,
//       );

//       if (!mounted) return;

//       setState(() {
//         this.qrCode = qrCode;
//       });
//     } on PlatformException {
//       qrCode = 'Failed to get platform version.';
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';

// class Qrscanner extends StatefulWidget {
//   @override
//   _QrscannerState createState() => _QrscannerState();
// }

// class _QrscannerState extends State<Qrscanner> {
//   String qrCodeResult;
//   String source;
//   String dest;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//         Color.fromRGBO(143, 148, 251, 1),
//         Color.fromRGBO(143, 148, 251, .6),
//       ])),
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0.0,
//             title: Text('SCANNER',
//                 style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 20.0,
//                     color: Colors.white)),
//             centerTitle: true,
//           ),
//           body: ListView(children: [
//             Stack(
//               children: [
//                 Container(
//                     height: MediaQuery.of(context).size.height - 80.0,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent),
//                 Positioned(
//                     top: 20.0,
//                     child: Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(45.0),
//                               topRight: Radius.circular(45.0),
//                             ),
//                             color: Colors.white),
//                         height: MediaQuery.of(context).size.height - 90.0,
//                         width: MediaQuery.of(context).size.width)),
//                 Center(
//                   child: Column(children: <Widget>[
//                     SizedBox(height: 100),
//                     tripcard(),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                         child: Container(
//                           height: 50,
//                           width: 350,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               gradient: LinearGradient(colors: [
//                                 Color.fromRGBO(143, 148, 251, 1),
//                                 Color.fromRGBO(143, 148, 251, .6),
//                               ])),
//                           child: Center(
//                               child: Text(
//                             "Scan QR Code",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                         onTap: () async {
//                           ScanResult codeScanner =
//                               // ignore: await_only_futures
//                               await BarcodeScanner.scan(); //barcode scnner
//                           if (codeScanner != null) {
//                             setState(() {
//                               if (source == null) {
//                                 source = codeScanner.rawContent;
//                               } else {
//                                 dest = codeScanner.rawContent;
//                               }
//                             });
//                           }
//                         }),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                         child: Container(
//                           height: 50,
//                           width: 350,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               gradient: LinearGradient(colors: [
//                                 Color.fromRGBO(143, 148, 251, 1),
//                                 Color.fromRGBO(143, 148, 251, .6),
//                               ])),
//                           child: Center(
//                               child: Text(
//                             "Sign Out",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                         ),
//                         onTap: () {})
//                   ]),
//                 ),
//               ],
//             ),
//           ])),
//     );
//   }

//   Widget tripcard() => Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           width: 250,
//           height: 300,
//           alignment: Alignment.center,
//           padding: EdgeInsets.all(25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Trip card',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Started from',
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 source == null ? 'Please Scan At the Starting Point' : source,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'To',
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 dest == null ? 'Please Scan At the dropping Point' : dest,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Fare : 50',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
// }
