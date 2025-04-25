import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'course/bloc/course_bloc.dart';
import 'course/bloc/course_event.dart';
import 'course/data_provider/course_data_provider.dart';
import 'course/repository/course_repository.dart';
import 'course/screens/course_list.dart';
import 'course/screens/course_routes.dart';
import 'bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  final CourseDataProvider courseDataProvider = CourseDataProvider(
    httpClient: http.Client(),
  );

  final CourseRepository courseRepository = CourseRepository(
    dataProvider: courseDataProvider,
  );

  runApp(CourseApp(courseRepository: courseRepository));
}

class CourseApp extends StatelessWidget {
  final CourseRepository courseRepository;

  const CourseApp({Key? key, required this.courseRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: courseRepository,
      child: BlocProvider(
        create: (context) => CourseBloc(repository: courseRepository)
          ..add(CourseLoad()),
        child: MaterialApp(
          title: 'Course Management App',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF2196F3, {
              50: Color(0xFFE3F2FD),
              100: Color(0xFFBBDEFB),
              200: Color(0xFF90CAF9),
              300: Color(0xFF64B5F6),
              400: Color(0xFF42A5F5),
              500: Color(0xFF2196F3),
              600: Color(0xFF1E88E5),
              700: Color(0xFF1976D2),
              800: Color(0xFF1565C0),
              900: Color(0xFF0D47A1),
            }),
            appBarTheme: AppBarTheme(
              color: Color(0xFF2196F3),
              elevation: 0,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF2196F3),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2196F3),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF2196F3)),
              ),
            ),
          ),
          home: const CourseList(),
        ),
      ),
    );
  }
}