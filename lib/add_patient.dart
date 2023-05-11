// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/patient.dart';

class AddPatientPage extends StatefulWidget {
  const AddPatientPage({
    Key? key,
    required this.doctorId,
  }) : super(key: key);
  final String doctorId;

  @override
  _AddPatientPageState createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const GapHeight(height: 30),
                TextFormField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Patient ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Patient ID';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Patient Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Patient Name';
                    }
                    return null;
                  },
                ),
                const GapHeight(height: 30),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState != null &&
                        _formKey.currentState!.validate()) {
                      _add();
                    }
                  },
                  child: Container(
                    width: getSize(context, 200),
                    height: getSize(context, 40),
                    decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Text('Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                const GapHeight(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _add() async {
    String id = _idController.text;
    String name = _nameController.text;

    FirebaseFirestore.instance
        .collection("patients")
        .doc(id)
        .set(Patient(id: id, name: name, doctorId: widget.doctorId).toJson());

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Patient Added'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
