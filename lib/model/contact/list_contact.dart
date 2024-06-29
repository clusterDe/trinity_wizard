// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:trinity_wizard/model/contact/contact_model.dart';

class ListContact {
  List<ContactModel>? data;

  ListContact({
    this.data,
  });

  ListContact copyWith({
    List<ContactModel>? data,
  }) {
    return ListContact(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ListContact.fromMap(Map<String, dynamic> map) {
    return ListContact(
      data: map['data'] != null
          ? List<ContactModel>.from(
              (map['data'] as List<dynamic>).map<ContactModel?>(
                (x) => ContactModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListContact.fromJson(String source) =>
      ListContact.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ListContact(data: $data)';

  @override
  bool operator ==(covariant ListContact other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
