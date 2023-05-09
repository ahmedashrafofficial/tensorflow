// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Xray extends Equatable {
  final String? url;
  final int? date;
  const Xray({
    this.url,
    this.date,
  });

  @override
  List<Object?> get props => [url, date];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'date': date,
    };
  }

  factory Xray.fromJson(Map<String, dynamic> map) {
    return Xray(
      url: map['url'],
      date: int.parse(map['date']),
    );
  }
}
