import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/sizes.dart';
import 'package:tensor_flow_app/patient.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.id});
  final String id;

  Future<List<Patient>> _getPatients() async {
    var snapshot = await FirebaseFirestore.instance
        .collection("patients")
        .where("doctorId", isEqualTo: id)
        .get();
    return snapshot.docs.map((e) {
      return Patient.fromMap(e.data());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: backgroundColor,
      //   onPressed: () => Navigator.pushNamed(context, Routes.uploadRoute,
      //       arguments: patient),
      //   child: const Icon(Icons.add),
      // ),
      body: FutureBuilder<List<Patient>>(
          future: _getPatients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Padding(
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
                      Expanded(
                        child: ListView.separated(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => GestureDetector(
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
                            separatorBuilder: (context, index) => const Divider(
                                  height: 10,
                                  thickness: 3,
                                  color: backgroundColor,
                                )),
                      ),
                      Container(
                        height: getSize(context, 150),
                        color: const Color(0xffE8F3F1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      "The Power of Palumovision and how it works!",
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: const Color(0xff101623),
                                        fontSize: getSize(context, 16),
                                        fontFamily: "Inter",
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: getSize(context, 120),
                                    height: getSize(context, 30),
                                    decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(50)),
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
                );
              } else {
                return const Center(child: Text("No Patients Found"));
              }
            }
            return const SizedBox();
          }),
    );
  }
}
