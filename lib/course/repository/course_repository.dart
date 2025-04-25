import '../data_provider/course_data_provider.dart';
import '../models/course.dart';

class CourseRepository {
  final CourseDataProvider dataProvider;

  CourseRepository({required this.dataProvider});

  Future<Course> createCourse(Course course) async {
    return await dataProvider.createCourse(course);
  }

  Future<List<Course>> getCourses() async {
    return await dataProvider.getCourses();
  }

  Future<Course> getCourse(String id) async {
    return await dataProvider.getCourse(id);
  }

  Future<Course> updateCourse(Course course) async {
    return await dataProvider.updateCourse(course);
  }

  Future<void> deleteCourse(String id) async {
    return await dataProvider.deleteCourse(id);
  }
}