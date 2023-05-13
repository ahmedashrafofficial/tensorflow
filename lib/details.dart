// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tensor_flow_app/SplashScreen.dart';
import 'package:tensor_flow_app/config/device_size.dart';
import 'package:tensor_flow_app/config/routes/app_routes.dart';
import 'package:tensor_flow_app/config/sizes.dart';

import 'package:tensor_flow_app/patient.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key? key,
    required this.patient,
  }) : super(key: key);
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${patient.name}"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: () => Navigator.pushNamed(context, Routes.uploadRoute,
              arguments: patient),
          child: const Icon(Icons.add),
        ),
        body: ListView.separated(
            itemCount: patient.images!.length,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: patient.images![index].url!,
                          width: getSize(context, 300),
                          height: getSize(context, 300),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Prediction : ${patient.images![index].name}",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: getSize(context, 18))),
                      const GapHeight(height: 8),
                      Text("Probability : ${patient.images![index].confidence}",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: getSize(context, 17))),
                      const GapHeight(height: 8),
                      Text(
                          "Date : ${DateFormat("yyyy:MM:dd hh:mm:ss a").format(DateTime.fromMillisecondsSinceEpoch(patient.images![index].date!))}",
                          style: TextStyle(
                              color: backgroundColor,
                              fontSize: getSize(context, 16))),
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  height: 50,
                  indent: 10,
                  endIndent: 10,
                  color: backgroundColor,
                )));
  }
}
