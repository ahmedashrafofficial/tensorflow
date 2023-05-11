import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/patient.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.doctorId});
  final String doctorId;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pinController = TextEditingController();
  String? _patientId;
  final FocusNode _focusNode = FocusNode();
  Future<List<Patient>>? patients;
  Future<List<Patient>> _getPatients() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("patients")
        .where("doctorId", isEqualTo: widget.doctorId)
        .get();
    return snapshot.docs.map((e) {
      return Patient.fromMap(e.data());
    }).toList();
  }

  Future<List<Patient>> _getPatientById() async {
    if (_patientId!.isEmpty) {
      return _getPatients();
    }
    var snapshot = await FirebaseFirestore.instance
        .collection("patients")
        .where("id", isEqualTo: _patientId)
        .get();
    // _patientId = null;
    debugPrint(snapshot.docs[0].data().toString());

    return snapshot.docs.map((e) {
      return Patient.fromMap(e.data());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    patients = _getPatients();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: () => Navigator.pushNamed(context, Routes.addPatientRoute,
              arguments: widget.doctorId),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: getSize(context, 200),
                  child: Text(
                    "Your Trusted Lung Diagnosis Assistant",
                    style: TextStyle(
                      color: const Color(0xff101623),
                      fontSize: getSize(context, 18),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const GapHeight(height: 20),
                TextFormField(
                  focusNode: _focusNode,
                  controller: _pinController,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      debugPrint("hna search");

                      _patientId = _pinController.text;
                    });
                  },
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: 'Search By ID',
                  ),
                ),
                const GapHeight(height: 20),
                FutureBuilder<List<Patient>>(
                    future: _patientId != null ? _getPatientById() : patients,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        debugPrint("hna");

                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          return Expanded(
                            child: ListView.separated(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.detailsRoute,
                                            arguments: snapshot.data![index]);
                                      },
                                      child: Container(
                                        height: getSize(context, 80),
                                        decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                  "Patient : ${snapshot.data?[index].name}",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  "ID : ${snapshot.data?[index].id}",
                                                  style: const TextStyle(
                                                      color: Colors.white)),
                                            ]),
                                      ),
                                    ),
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      height: 50,
                                      thickness: 1,
                                      endIndent: 30,
                                      indent: 30,
                                      color: backgroundColor,
                                    )),
                          );
                        } else {
                          return const Expanded(
                            child: Center(child: Text("No Patients Found")),
                          );
                        }
                      }
                      return const SizedBox();
                    }),
                Container(
                  height: getSize(context, 150),
                  color: const Color(0xffE8F3F1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                "The Power of Palumovision and how it works!",
                                style: TextStyle(
                                  color: const Color(0xff101623),
                                  fontSize: getSize(context, 16),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 16.0),
                              width: getSize(context, 120),
                              height: getSize(context, 30),
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                child: Text('Learn More',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: getSize(context, 16),
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/7xm6.png',
                        width: getSize(context, 130),
                        height: getSize(context, 130),
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
