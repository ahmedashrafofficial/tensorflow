// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:tensor_flow_app/xray.dart';

class Patient extends Equatable {
  final String? id;
  final String? name;
  final int? doctorId;
  final List<Xray>? images;
  const Patient({
    this.id,
    this.name,
    this.doctorId,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'doctorId': doctorId,
      'images': images?.map((x) => x.toJson()).toList(),
    };
  }

  factory Patient.fromMap(Map<String, dynamic> map) {
    // print(map['images']);
    return Patient(
      id: map['id'],
      name: map['name'],
      doctorId: int.parse(map['doctorId']),
      images: imagesListString(map['images']),
    );
  }

  static List<Xray> imagesListString(List<dynamic>? list) {
    List<Xray> newList = [];
    if (list != null) {
      for (var e in list) {
        var xray = Xray.fromJson(e);
        newList.add(xray);
        print(newList);
      }
      print(newList);

      return newList;
      //  list.map((e) => Xray.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  @override
  List<Object?> get props => [id, doctorId, images];
}
