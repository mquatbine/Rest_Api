import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/course.dart';
import '../bloc/blocs.dart';

class CourseAddUpdate extends StatefulWidget {
  final Course? course;

  const CourseAddUpdate({Key? key, this.course}) : super(key: key);

  @override
  _CourseAddUpdateState createState() => _CourseAddUpdateState();
}

class _CourseAddUpdateState extends State<CourseAddUpdate> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;
  late TextEditingController _titleController;
  late TextEditingController _ectsController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.course?.id ?? '');
    _titleController = TextEditingController(text: widget.course?.title ?? '');
    _ectsController = TextEditingController(text: widget.course?.ects.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.course?.description ?? '');
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _ectsController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Add New Course' : 'Edit Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(
                controller: _codeController,
                label: 'Course Code',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course code';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _titleController,
                label: 'Course Title',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _ectsController,
                label: 'Course ECTS',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ECTS credits';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Course Description',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    int? maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final courseBloc = context.read<CourseBloc>();

      final course = Course(
        id: _codeController.text,
        title: _titleController.text,
        description: _descriptionController.text,
        ects: int.parse(_ectsController.text),
      );

      if (widget.course == null) {
        courseBloc.add(CourseCreate(course));
      } else {
        courseBloc.add(CourseUpdate(course));
      }

      Navigator.of(context).pop();
    }
  }
}