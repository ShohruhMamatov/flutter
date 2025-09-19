class Student {
  String name;
  int age;
  List<double> grades;

  Student(this.name, this.age, this.grades);

  double calculateAverageGrade() {
    if (grades.isEmpty) return 0.0;
    double sum = grades.reduce((a, b) => a + b);
    return sum / grades.length;
  }
}
