import 'dart:io';
import 'package:flutter/material.dart';

// import 'painters/text_detector_painter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class TextImage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ImageCrop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? selectedFile;
  bool _inProcess = false;
  String imgtxt = 'Hi';
  // TextDetector textDetector = GoogleMlKit.vision.textDetector();
  bool isBusy = false;
  String albumName = 'Media';
  CustomPaint? customPaint;

  Widget getImageWidget() {
    if (selectedFile != null) {
      return Image.file(
        selectedFile!,
        width: 340,
        height: 194,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/images/P1.png",
        width: 340,
        height: 194,
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    PickedFile? image = await ImagePicker().getImage(source: source);

    if (image != null) {
      File cropped = (await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 0.25),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarTitle: "RPS Cropper",
            statusBarColor: Colors.deepOrange.shade900,
            backgroundColor: Colors.white,
          )))!;

      this.setState(() {
        selectedFile = cropped;
        // inputImage = selectedFile;
        GallerySaver.saveImage(selectedFile!.path, albumName: albumName);

        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImageWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "Camera",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                      // GallerySaver.saveImage(image!.path, albumName: albumName);
                    }),
                MaterialButton(
                    color: Colors.deepOrange,
                    child: Text(
                      "Device",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      getImage(ImageSource.gallery);
                      // processImage(selectedFile!);
                      // InputImage inputImage =
                      //     InputImage.fromFile(selectedFile!);
                      // final recognisedText =
                      //     await textDetector.processImage(inputImage);
                      // imgtxt = recognisedText.text;
                    }),
              ],
            ),
            Container(
              child: Text(imgtxt),
            )
          ],
        ),
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.95,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Center()
      ],
    ));
  }
}
