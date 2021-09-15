import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpggasmaster1/Screens/GasBillSystem.dart';

import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as imglib;

class cropper extends StatefulWidget {
  const cropper({
    Key? key,
    required this.camera,
  }) : super(key: key);
  final CameraDescription camera;

  @override
  _cropperState createState() => _cropperState();
}

class _cropperState extends State<cropper> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  List _outputs = [1];
  List _outputs1 = [1];
  List _outputs2 = [1];
  List _outputs3 = [1];
  List _outputs4 = [1];
  List _outputs5 = [1];
  List _outputs6 = [1];
  List _outputs7 = [1];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  var avg;
  brightnesslevelcheck(imglib.Image src) {
    final pixels = src.data;
    double colorSum = 0;

    for (int i = 0; i < pixels.length; i++) {
      int pixel = pixels[i];
      int b = (pixel & 0x00FF0000) >> 16;
      int g = (pixel & 0x0000FF00) >> 8;
      int r = (pixel & 0x000000FF);
      avg = (r + g + b) / 3;
      colorSum += avg;
    }

    return colorSum / pixels.length;
  }

  // imglib.Image grayscale(imglib.Image src) {
  //   final p = src.getBytes();
  //   for (var i = 0, len = p.length; i < len; i += 4) {
  //     final l = imglib.getLuminanceRgb(p[i], p[i + 1], p[i + 2]);
  //     p[i] = l;
  //     p[i + 1] = l;
  //     p[i + 2] = l;
  //   }
  //   return src;
  // }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    List? output;
    var a;
    print("Ocr started");

    output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 10,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
    });
    print("ResultOne");
    return output;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    Tflite.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cropping"),
      ),
      // bottomNavigationBar: Image.asset("assets/new1.jpeg"),
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(fit: StackFit.expand, children: [
                CameraPreview(_controller),
                cameraOverlay(padding: 0, aspectRatio: 50, color: Colors.white)
              ]);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          // try {
          final image = await _controller.takePicture();
          print("path:" + image.path);

//starts here***********************************************************************
          ImageProperties properties =
              await FlutterNativeImage.getImageProperties(image.path);
          File output = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);
          print("output path:" + output.path);

          var bytes = await File(output.path).readAsBytes();
          imglib.Image? src = imglib.decodeImage(bytes);
          // var bright = await brightnesslevelcheck(src!);
          // print("Before grey scaleBright" + bright.toString());

          // if (bright > double.parse(130.toString())) {
          //   src = await imglib.brightness(src, -20);
          // } else {}

          src = await imglib.grayscale(src!);
          // bright = await brightnesslevelcheck(src);
          // print("Bright" + bright.toString());

          var split;
          final int xLength = (properties.width! / 8).round();
          final int yLength = (properties.height!).round();
          print("length" + xLength.toString() + yLength.toString());

          File output1 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output2 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output3 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output4 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output5 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output6 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output7 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);

          File output8 = await FlutterNativeImage.cropImage(
              image.path, 0, 0, properties.width!, 80);
          int x = 0;
          print("List created");

          // for (int y = 0; y < 3; y++)
          for (int i = 0; i < 8; i++) {
            print("path testing:" + output.path);

            try {
              split = imglib.copyCrop(src, x, 0, xLength, yLength);
              x = x + xLength;
              print("Splitted");
            } catch (e) {
              print("Not splitted" + e.toString());
            }

            var jpg = imglib.encodeJpg(split);
            print("cropping executed");
            if (i == 0) await File(output1.path).writeAsBytes(jpg);

            if (i == 1) await File(output2.path).writeAsBytes(jpg);

            if (i == 2) await File(output3.path).writeAsBytes(jpg);

            if (i == 3) await File(output4.path).writeAsBytes(jpg);

            if (i == 4) await File(output5.path).writeAsBytes(jpg);

            if (i == 5) await File(output6.path).writeAsBytes(jpg);

            if (i == 6) await File(output7.path).writeAsBytes(jpg);

            if (i == 7) await File(output8.path).writeAsBytes(jpg);
          }
          print("cropping completed");
//Ends here ************************************************************************

          GallerySaver.saveImage(output.path, albumName: "Media");
          // GallerySaver.saveImage(output1.path, albumName: "Media");
          // GallerySaver.saveImage(output2.path, albumName: "Media");
          // GallerySaver.saveImage(output3.path, albumName: "Media");
          // GallerySaver.saveImage(output4.path, albumName: "Media");
          // GallerySaver.saveImage(output5.path, albumName: "Media");
          // GallerySaver.saveImage(output6.path, albumName: "Media");
          // GallerySaver.saveImage(output7.path, albumName: "Media");
          // GallerySaver.saveImage(output8.path, albumName: "Media");
          print(" uploaded");

          // print("check null");
          // print(await classifyImage(output1));
//OCR starts here***********************************************************************
          _outputs = await classifyImage(output1);
          // print("result" + _outputs[0]["label"]);

          _outputs1 = await classifyImage(output2);
          _outputs2 = await classifyImage(output3);
          _outputs3 = await classifyImage(output4);
          _outputs4 = await classifyImage(output5);
          _outputs5 = await classifyImage(output6);
          _outputs6 = await classifyImage(output7);
          _outputs7 = await classifyImage(output8);
//OCR ends here***********************************************************************
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(
                // Pass the automatically generated path to
                // the DisplayPictureScreen widget.
                imagePath: output.path,
                imagePath1: output1.path,
                imagePath2: output2.path,
                imagePath3: output3.path,
                imagePath4: output4.path,
                imagePath5: output5.path,
                imagePath6: output6.path,
                imagePath7: output7.path,
                imagePath8: output8.path,
                outputs: _outputs,
                outputs1: _outputs1,
                outputs2: _outputs2,
                outputs3: _outputs3,
                outputs4: _outputs4,
                outputs5: _outputs5,
                outputs6: _outputs6,
                outputs7: _outputs7,
              ),
            ),
          );
          // } catch (e) {
          //   print("Photo not taken" + e.toString());
          // }
        },
      ),
    );
  }
}

Widget cameraOverlay({double? padding, double? aspectRatio, Color? color}) {
  return LayoutBuilder(builder: (context, constraints) {
    double parentAspectRatio = constraints.maxWidth / constraints.maxHeight;
    double horizontalPadding;
    double verticalPadding;

    if (parentAspectRatio < aspectRatio!) {
      horizontalPadding = padding!;
      verticalPadding = (constraints.maxHeight -
              ((constraints.maxWidth - 2 * padding) / aspectRatio)) /
          2;
    } else {
      verticalPadding = padding!;
      horizontalPadding = (constraints.maxWidth -
              ((constraints.maxHeight - 2 * padding) * aspectRatio)) /
          2;
    }
    return Stack(fit: StackFit.expand, children: [
      Align(
          alignment: Alignment.centerRight,
          child: Container(width: horizontalPadding, color: color)),
      Align(
          alignment: Alignment.centerLeft,
          child: Container(width: horizontalPadding, color: color)),
      Align(
          alignment: Alignment.centerRight,
          child: Container(width: horizontalPadding, color: color)),
      Align(
          alignment: Alignment.center,
          child: Container(
              margin: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color)),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: EdgeInsets.only(
                  left: horizontalPadding, right: horizontalPadding),
              height: verticalPadding,
              color: color)),
    ]);
  });
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final String imagePath1;
  final String imagePath2;
  final String imagePath3;
  final String imagePath4;
  final String imagePath5;
  final String imagePath6;
  final String imagePath7;
  final String imagePath8;
  List? outputs;
  List? outputs1;
  List? outputs2;
  List? outputs3;
  List? outputs4;
  List? outputs5;
  List? outputs6;
  List? outputs7;

  DisplayPictureScreen({
    Key? key,
    required this.imagePath,
    required this.imagePath1,
    required this.imagePath2,
    required this.imagePath3,
    required this.imagePath4,
    required this.imagePath5,
    required this.imagePath6,
    required this.imagePath7,
    required this.imagePath8,
    required this.outputs,
    required this.outputs1,
    required this.outputs2,
    required this.outputs3,
    required this.outputs4,
    required this.outputs5,
    required this.outputs6,
    required this.outputs7,
  }) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  var ocrText;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(widget.imagePath)),
          Padding(padding: EdgeInsets.all(10)),
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 0,
              crossAxisCount: 4,
              children: <Widget>[
                Image.file(
                  File(widget.imagePath1),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath2),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath3),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath4),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath5),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath6),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath7),
                  fit: BoxFit.fill,
                ),
                Image.file(
                  File(widget.imagePath8),
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
          widget.outputs != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs1 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs1![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs1![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs2 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs2![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs2![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs3 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs3![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs3![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs4 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs4![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs4![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs5 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs5![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs5![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs6 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs6![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs6![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),
          widget.outputs7 != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.outputs7![0]["label"],
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    // Text(
                    //   "Con:",
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                    // Text(
                    //   widget.outputs7![0]["confidence"].toString(),
                    //   style: TextStyle(color: Colors.black, fontSize: 20),
                    // ),
                  ],
                )
              : Container(child: Text("")),

          ElevatedButton(
              child: Text("Next"),
              onPressed: () {
                setState(() {
                  print("result" + widget.outputs![0]["label"]);
                  // var a = widget.outputs![0]["label"];
                  List<String> total = [
                    widget.outputs![0]["label"],
                    widget.outputs1![0]["label"],
                    widget.outputs2![0]["label"],
                    widget.outputs3![0]["label"],
                    widget.outputs4![0]["label"],
                    widget.outputs5![0]["label"],
                    widget.outputs6![0]["label"],
                    widget.outputs7![0]["label"]
                  ];
                  ocrText = total.join();
                  // print("a" + a.toString());
                  // ocrText.join(a);
                  print(ocrText);

                  // ocrText.join(widget.outputs1![0]["label"]);
                  // ocrText.join(widget.outputs2![0]["label"]);
                  // ocrText.join(widget.outputs3![0]["label"]);
                  // ocrText.join(widget.outputs4![0]["label"]);
                  // ocrText.join(widget.outputs5![0]["label"]);
                  // ocrText.join(widget.outputs6![0]["label"]);
                  // ocrText.join(widget.outputs7![0]["label"]);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GasBillSystems(
                      ocrReading: ocrText.toString(),
                    ),
                  ),
                );
              })
          // outputs != null
          //     ? Text(
          //         "Atsuya",
          //         style: TextStyle(color: Colors.black, fontSize: 20),
          //       )
          //     : Container(child: Text("Atsuya"))
        ],
      ),
    );
  }
}
