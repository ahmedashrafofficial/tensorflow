// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/themes/app_theme.dart';
import 'package:tensor_flow_app/firebase_options.dart';
import 'package:tflite/tflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  XFile? _image;
  List? _outputs;
  final ImagePicker _picker = ImagePicker();
  // final options = FaceDetectorOptions();
  // final faceDetector = FaceDetector(
  //     options: FaceDetectorOptions(
  //         enableClassification: true, enableLandmarks: true));
  Rect? boundingBox;

  void _getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
      print("hna1");
      classifyImage(image);
    }
  }

  void classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );

    // final inputImage = InputImage.fromFilePath(image.path);
    // final List<Face> faces = await faceDetector.processImage(inputImage);
    // for (Face face in faces) {
    //   boundingBox = face.boundingBox;
    //   final double? rotX =
    //       face.headEulerAngleX; // Head is tilted up and down rotX degrees
    //   final double? rotY =
    //       face.headEulerAngleY; // Head is rotated to the right rotY degrees
    //   final double? rotZ =
    //       face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

    //   // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
    //   // eyes, cheeks, and nose available):
    //   final FaceLandmark leftEar = face.landmarks[FaceLandmarkType.leftEar]!;
    //   final Point<int> leftEarPos = leftEar.position;

    //   // If classification was enabled with FaceDetectorOptions:
    //   if (face.smilingProbability != null) {
    //     final double? smileProb = face.smilingProbability;
    //   }

    //   // If face tracking was enabled with FaceDetectorOptions:
    //   if (face.trackingId != null) {
    //     final int? id = face.trackingId;
    //   }
    // }
    setState(() {
      _outputs = output;
    });
  }

  Future<void> _initTenserFlow() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void initState() {
    _initTenserFlow();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    await Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image == null
              ? const SizedBox()
              : Stack(
                  children: [
                    Image.file(
                      File(_image!.path),
                      fit: BoxFit.fill,
                      width: 300,
                      height: 300,
                    ),
                    if (boundingBox != null) ...{
                      Positioned(
                          top: boundingBox!.topLeft.dy,
                          left: boundingBox!.topLeft.dx,
                          child: Container(
                            width: boundingBox!.width / 2,
                            height: boundingBox!.height / 2,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.red)),
                          ))
                    }
                  ],
                ),
          const SizedBox(height: 20),
          if (_outputs != null) ...{
            Text(
              '${_outputs![0]["label"]} : ${(_outputs![0]["confidence"] * 100)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Text(
            //   '$_outputs',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          }
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImage,
        tooltip: 'get image',
        child: const Icon(Icons.add),
      ),
    );
  }
}
