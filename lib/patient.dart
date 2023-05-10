// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:tensor_flow_app/xray.dart';

class Patient extends Equatable {
  final String? id;
  final String? name;
  final String? doctorId;
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
    return Patient(
      id: map['id'],
      name: map['name'],
      doctorId: map['doctorId'],
      images: imagesListString(map['images']),
    );
  }

  static List<Xray> imagesListString(List<dynamic>? list) {
    List<Xray> newList = [];
    if (list != null) {
      for (var e in list) {
        var xray = Xray.fromJson(e);
        newList.add(xray);
      }

      return newList;
    } else {
      return List.empty();
    }
  }

  @override
  List<Object?> get props => [id, doctorId, images];

  Patient copyWith({
    String? id,
    String? name,
    String? doctorId,
    List<Xray>? images,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      doctorId: doctorId ?? this.doctorId,
      images: this.images == null
          ? images
          : this.images!.followedBy(images!).toList(),
    );
  }
}
