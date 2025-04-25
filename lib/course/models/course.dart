import 'package:equatable/equatable.dart';
import 'dart:convert';

class Course extends Equatable {
  final String? id;
  final String title;
  final String description;
  final int ects;

  const Course({
    this.id,
    required this.title,
    required this.description,
    required this.ects,
  });

  @override
  List<Object?> get props => [id, title, description, ects];

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      ects: json['ects'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ects': ects,
    };
  }

  Course copyWith({
    String? id,
    String? title,
    String? description,
    int? ects,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ects: ects ?? this.ects,
    );
  }
}