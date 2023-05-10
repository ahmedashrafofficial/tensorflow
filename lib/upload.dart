// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/patient.dart';
import 'package:tensor_flow_app/xray.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({
    Key? key,
    required this.patient,
  }) : super(key: key);
  final Patient patient;

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _image;
  List? _outputs;
  late final ImagePicker _picker = ImagePicker();

  void _getImage(ImageSource source) async {
    var image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = image;
      });
      classifyImage(image);
    }
  }

  void classifyImage(XFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );

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
    // _initTenserFlow();
    super.initState();
  }

  @override
  Future<void> dispose() async {
    // await Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  _getImage(ImageSource.gallery);
                },
                child: Container(
                  width: getSize(context, 150),
                  height: getSize(context, 50),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text('Upload From Gallery',
                        style: TextStyle(
                            fontSize: getSize(context, 14),
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // _getImage(ImageSource.camera);
                  FirebaseFirestore.instance
                      .collection("patients")
                      .doc("gLeO7Z6BWp4qh3EhNH2b")
                      .set(
                          widget.patient.copyWith(images: [
                            const Xray(
                                url: "test",
                                name: "covid19",
                                confidence: 97,
                                date: 1683695032232)
                          ]).toJson(),
                          SetOptions(
                            merge: true,
                          ));
                },
                child: Container(
                  width: getSize(context, 150),
                  height: getSize(context, 50),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text('Upload From Camera',
                        style: TextStyle(
                            fontSize: getSize(context, 14),
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
          const GapHeight(height: 20),
          if (_image != null) ...{
            Image.file(
              File(_image!.path),
              fit: BoxFit.fill,
              width: getSize(context, 300),
              height: getSize(context, 300),
            ),
          },
          if (_outputs != null) ...{
            Text(
              'Name : ${_outputs![0]["label"]})}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Confidence : ${double.parse(_outputs![0]["confidence"] * 100).toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const GapHeight(height: 20),
            GestureDetector(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("patients")
                    .doc("gLeO7Z6BWp4qh3EhNH2b")
                    .update(
                        const Xray(url: "test", name: "covid", confidence: 94)
                            .toJson());
              },
              child: Container(
                width: getSize(context, 150),
                height: getSize(context, 50),
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                  child: Text('Upload To Cloud',
                      style: TextStyle(
                          fontSize: getSize(context, 14),
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          }
        ],
      ),
    );
  }
}
