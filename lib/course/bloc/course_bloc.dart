import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../repository/course_repository.dart';
import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseRepository repository;

  CourseBloc({required this.repository}) : super(CourseInitial()) {
    on<CourseLoad>(_onCourseLoad);
    on<CourseCreate>(_onCourseCreate);
    on<CourseUpdate>(_onCourseUpdate);
    on<CourseDelete>(_onCourseDelete);
  }

  void _onCourseLoad(CourseLoad event, Emitter<CourseState> emit) async {
    emit(CourseLoading());
    try {
      final courses = await repository.getCourses();
      emit(CourseLoadSuccess(courses));
    } catch (error) {
      if (kDebugMode) {
        print('Error loading courses: $error');
      }
      emit(CourseOperationFailure());
    }
  }

  void _onCourseCreate(CourseCreate event, Emitter<CourseState> emit) async {
    try {
      await repository.createCourse(event.course);
      final courses = await repository.getCourses();
      emit(CourseLoadSuccess(courses));
    } catch (error) {
      if (kDebugMode) {
        print('Error creating course: $error');
      }
      emit(CourseOperationFailure());
    }
  }

  void _onCourseUpdate(CourseUpdate event, Emitter<CourseState> emit) async {
    try {
      await repository.updateCourse(event.course);
      final courses = await repository.getCourses();
      emit(CourseLoadSuccess(courses));
    } catch (error) {
      if (kDebugMode) {
        print('Error updating course: $error');
      }
      emit(CourseOperationFailure());
    }
  }

  void _onCourseDelete(CourseDelete event, Emitter<CourseState> emit) async {
    try {
      await repository.deleteCourse(event.id);
      final courses = await repository.getCourses();
      emit(CourseLoadSuccess(courses));
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting course: $error');
      }
      emit(CourseOperationFailure());
    }
  }
}