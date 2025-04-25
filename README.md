dart` with your actual API endpoint
4. Run the app:
   ```
   flutter run
   ```

## Features
- List all courses
- Add new courses
- Edit existing courses
- Delete courses
- View course details

## Backend API Requirements
The app expects a REST API with these endpoints:
- `GET /courses` - Retrieve all courses
- `GET /courses/:id` - Retrieve a specific course
- `POST /courses` - Create a new course
- `PUT /courses/:id` - Update an existing course
- `DELETE /courses/:id` - Delete a course

## State Management
Uses `flutter_bloc` for managing application state with:
- Events
- States
- Bloc logic

## Dependencies
- `flutter_bloc`: State management
- `http`: Network requests
- `equatable`: Equality comparisons

## Troubleshooting
- Ensure backend API is running
- Check network connectivity
- Verify API endpoint URL

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
[Specify your license here]