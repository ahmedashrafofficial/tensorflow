import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
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
    // print(snapshot.docs[0].data());
    return snapshot.docs.map((e) {
      // print(e.data());
      return Patient.fromMap(e.data());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Patient>>(
          future: _getPatients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: getSize(context, 200),
                            decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text("${snapshot.data?[index].name}"),
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        const GapHeight(height: 10));
              } else {
                return const Center(child: Text("No Patients Found"));
              }
            }
            return Container(
              width: 375,
              height: 812,
              color: Colors.white,
              padding: const EdgeInsets.only(
                top: 64,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 331,
                    height: 64,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 238,
                          child: Text(
                            "Your Trusted Lung Diagnosis Assistant",
                            style: TextStyle(
                              color: Color(0xff101623),
                              fontSize: 22,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 69),
                        Container(
                          width: 24,
                          height: 24,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 2,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 17,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const FlutterLogo(size: 17),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: 266,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 266,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: const Color(0xff199a8e),
                          ),
                          padding: const EdgeInsets.only(
                            left: 92,
                            right: 87,
                            top: 15,
                            bottom: 18,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Take a photo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: 266,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 266,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: const Color(0xff199a8e),
                          ),
                          padding: const EdgeInsets.only(
                            left: 67,
                            right: 62,
                            top: 15,
                            bottom: 18,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Choose from gallary ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: 266,
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 266,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: const Color(0xff199a8e),
                          ),
                          padding: const EdgeInsets.only(
                            left: 107,
                            right: 103,
                            top: 15,
                            bottom: 18,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                "Patients",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: 335,
                    height: 135,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 335,
                          height: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xffe8f3f1),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 121,
                                    height: 135,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 121,
                                          height: 135,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xffe8f3f1),
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            right: 3,
                                            top: 21,
                                            bottom: 1,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Opacity(
                                                opacity: 0.50,
                                                child: Container(
                                                  width: 113,
                                                  height: 113,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: SizedBox(
                                              width: 91,
                                              height: 131,
                                              child: FlutterLogo(size: 91),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                left: 10,
                                top: 17,
                                child: SizedBox(
                                  width: 271,
                                  child: Text(
                                    "The Power of Palumovision and how it works!",
                                    style: TextStyle(
                                      color: Color(0xff101623),
                                      fontSize: 18,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 26,
                                top: 86,
                                child: SizedBox(
                                  width: 97,
                                  height: 29,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 97,
                                        height: 29,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff199a8e),
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                          right: 16,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Text(
                                              "Learn more",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: 375,
                    height: 79,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 375,
                          height: 79,
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                            left: 258,
                            right: 93,
                            top: 28,
                            bottom: 27,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Stack(
                                  children: const [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
