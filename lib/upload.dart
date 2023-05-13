// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tensor_flow_app/config/api/api_consumer.dart';
import 'package:tensor_flow_app/config/api/api_consumer_impl.dart';
import 'package:tensor_flow_app/config/api/end_points.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/xray.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/patient.dart';

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
  Map<String, dynamic>? _outputs;
  bool _isLoading = false;
  bool _isLoading2 = false;
  late final ImagePicker _picker = ImagePicker();

  void _getImage(ImageSource source) async {
    var image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _isLoading2 = true;
        _image = image;
      });
      classifyImage(image);
    }
  }

  void classifyImage(XFile image) async {
    ApiConsumer dio = ApiConsumerImpl(client: Dio());
    String fileName = image.path.split('/').last;

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    var response = await dio.post(EndPoints.baseUrl, body: formData);
    _outputs = {
      'probability': response['probability'],
      'state': response['state']
    };
    setState(() {
      _isLoading2 = false;
    });
  }

  // void classifyImage(XFile image) async {
  //   var output = await Tflite.runModelOnImage(
  //     path: image.path,
  //   );

  //   setState(() {
  //     _outputs = output;
  //   });
  // }

  // Future<void> _initTenserFlow() async {
  //   await Tflite.loadModel(
  //     model: "assets/model.tflite",
  //     labels: "assets/labels.txt",
  //   );
  // }

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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: getSize(context, 50),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text('Upload From Gallery',
                        style: TextStyle(
                            fontSize: getSize(context, 10),
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _getImage(ImageSource.camera);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  height: getSize(context, 50),
                  decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text('Upload From Camera',
                        style: TextStyle(
                            fontSize: getSize(context, 10),
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
          if (!_isLoading2) ...{
            if (_outputs != null) ...{
              Text(
                'Prediction : ${_outputs!["state"]}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Probability : ${(double.parse(_outputs!["probability"].toString()) * 100).toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            }
          } else ...{
            const GapHeight(height: 20),
            const CircularProgressIndicator(
              color: backgroundColor,
            ),
          },
          if (_outputs != null) ...{
            const GapHeight(height: 20),
            if (!_isLoading) ...{
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  UploadTask uploadTask;

                  // Create a Reference to the file
                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child('images')
                      .child('/some-image.jpg');
                  final metadata = SettableMetadata(
                    contentType: 'image/jpeg',
                    customMetadata: {'picked-file-path': _image!.path},
                  );
                  uploadTask = ref.putFile(File(_image!.path), metadata);
                  await Future.value(uploadTask);
                  final link = await ref.getDownloadURL();
                  FirebaseFirestore.instance
                      .collection("patients")
                      .doc(widget.patient.id)
                      .set(
                          widget.patient.copyWith(images: [
                            Xray(
                                url: link,
                                name: '${_outputs!["state"]}',
                                confidence: double.parse((double.parse(
                                            _outputs!["probability"]
                                                .toString()) *
                                        100)
                                    .toStringAsFixed(2)),
                                date: DateTime.now().millisecondsSinceEpoch)
                          ]).toJson(),
                          SetOptions(
                            merge: true,
                          ));

                  Navigator.pushNamedAndRemoveUntil(context, Routes.homeRoute,
                      ModalRoute.withName(Routes.homeRoute),
                      arguments: widget.patient.doctorId);
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
              )
            } else ...{
              const CircularProgressIndicator(
                color: backgroundColor,
              )
            },
          }
        ],
      ),
    );
  }
}
