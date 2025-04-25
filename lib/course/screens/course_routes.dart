import 'package:flutter/material.dart';
import '../models/course.dart';
import 'course_list.dart';
import 'course_add_update.dart';
import 'course_detail.dart';

class CourseRoutes {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const CourseList());

      case '/add-course':
        return MaterialPageRoute(builder: (_) => const CourseAddUpdate());

      case '/edit-course':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
            builder: (_) => CourseAddUpdate(course: course)
        );

      case '/course-detail':
        final course = settings.arguments as Course;
        return MaterialPageRoute(
            builder: (_) => CourseDetail(course: course)
        );

      default:
        return null;
    }
  }
}