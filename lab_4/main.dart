import 'task1.1.dart';
import 'task1.2.dart';
import 'task1.3.dart';
import 'task1.4.dart';
import 'task1.5.dart';

void main() {
  var student = Student('Avazbek', 21, [85.5, 90.0, 78.5, 92.0]);

  print('Student: ${student.name}');
  print('Average Grade: ${student.calculateAverageGrade().toStringAsFixed(2)}');
}