import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lpggasmaster1/DB.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'GasBillSystem.dart';

final albumName = 'Media';
var ocrResult;
String a = "";
String? OcrResult1;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            // return CameraPreview(_controller);
            return Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomPaint(
                    foregroundPainter: OutlinePainter(),
                    child: CameraPreview(_controller),
                  ),
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();
            GallerySaver.saveImage(image.path, albumName: albumName);
            File? _imageFile;
            _imageFile = File(image.path);
            print("ImagePath:" + image.path);

            // If the picture was taken, display it on a new screen.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.file(File(imagePath)),
          ElevatedButton(
              child: Text("Get OcrResult"),
              onPressed: () async {
                Future<String> uploadPic(File _image1) async {
                  FirebaseStorage storage = FirebaseStorage.instance;
                  // String url;
                  Reference ref =
                      storage.ref().child("image1" + getRandomString(15));
                  TaskSnapshot uploadTask = await ref.putFile(
                    _image1,
                  );
                  return await uploadTask.ref.getDownloadURL();
                }

                a = await uploadPic(File(imagePath));
                print(a);
                ocrResult = (await http.get(
                    Uri.parse("https://ocr-appmeter.herokuapp.com/?ima=" + a)));
                OcrResult1 = ocrResult.body;
              }),
          // (ocrResult.body == null)
          //     ? CircularProgressIndicator()
          FutureBuilder(
              initialData: OcrResult1,
              builder: (context, snapshot) {
                return Text(
                  (OcrResult1 == null)
                      ? "Your Result will be Displayed Here Once You click Get OcrResult"
                      : ocrResult.body,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                );
              }),

          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GasBillSystems(),
                  ),
                );
              },
              child: Text('Next'))
        ],
      ),
    );
  }
}

// class OutlinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // Define a paint object

//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0
//       ..color = Colors.orange;

//     canvas.drawRRect(
//       RRect.fromRectAndRadius(
//           Rect.fromLTWH(10, 20, 325, 50), Radius.circular(0)),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(OutlinePainter oldDelegate) => false;
// }
class OutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define a paint object

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.orange;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(20, 200, 325, 50), Radius.circular(0)),
      paint,
    );
  }

  @override
  bool shouldRepaint(OutlinePainter oldDelegate) => false;
}

// canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), corner), paint);