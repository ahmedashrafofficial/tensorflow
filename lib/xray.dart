// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Xray extends Equatable {
  final String? url;
  final String? name;
  final int? date;
  final double? confidence;
  const Xray({
    this.url,
    this.name,
    this.date,
    this.confidence,
  });

  @override
  List<Object?> get props => [url, name, date, confidence];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'url': url,
      'date': date,
      'confidence': confidence,
    };
  }

  factory Xray.fromJson(Map<String, dynamic> map) {
    return Xray(
      name: map['name'],
      url: map['url'],
      date: map['date'],
      confidence: map['confidence'],
    );
  }
}
