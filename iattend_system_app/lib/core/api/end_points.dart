class EndPoints {
  static const String login = '/login';
  
  // Admin
  static const String registerStudent = '/register/student';
  static const String registerDoctor = '/register/doctor';
  static const String addSubject = '/admin/subjects';
  static const String enrollStudent = '/admin/enroll';
  static const String resetPassword = '/admin/reset-password';
  
  // Doctor
  static const String subjects = '/subjects';
  static const String recognize = '/recognize'; // أهم واحد
  
  // Student
  static const String studentSummary = '/student/summary';
}