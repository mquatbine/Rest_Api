import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseDataProvider {
  final http.Client httpClient;
  final String baseUrl = 'http://localhost:3001'; // Replace with your actual API base URL

  CourseDataProvider({required this.httpClient});

  Future<Course> createCourse(Course course) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl/courses'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course');
    }
  }

  Future<List<Course>> getCourses() async {
    final response = await httpClient.get(Uri.parse('$baseUrl/courses'));

    if (response.statusCode == 200) {
      final List<dynamic> courseList = jsonDecode(response.body);
      return courseList.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<Course> getCourse(String id) async {
    final response = await httpClient.get(Uri.parse('$baseUrl/courses/$id'));

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load course');
    }
  }

  Future<Course> updateCourse(Course course) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/courses/${course.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(course.toJson()),
    );

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update course');
    }
  }

  Future<void> deleteCourse(String id) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl/courses/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete course');
    }
  }
}