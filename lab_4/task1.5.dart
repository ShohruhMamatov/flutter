class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  double get area => width * height;

  double get perimeter => 2 * (width + height);
}
