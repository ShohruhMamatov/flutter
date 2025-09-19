import 'dart:convert';
import 'dart:math';

// Task 1: Shape Polymorphism
abstract class Shape {
  double area();
}

class Circle extends Shape {
  double radius;
  Circle(this.radius);

  @override
  double area() => pi * radius * radius;
}

class Rectangle extends Shape {
  double width, height;
  Rectangle(this.width, this.height);

  @override
  double area() => width * height;
}

// Task 2: Weapon Actions
abstract class Weapon {
  void action();
}

class Sword extends Weapon {
  @override
  void action() => print('Swinging!');
}

class Bow extends Weapon {
  @override
  void action() => print('Firing!');
}

// Task 3: Animal Feeder
abstract class Animal {
  void eat();
}

class Lion extends Animal {
  @override
  void eat() => print('Eating meat.');
}

class Goat extends Animal {
  @override
  void eat() => print('Eating grass.');
}

void feed(Animal animal) {
  animal.eat();
}

// Task 4: Payment Processing
abstract class PaymentMethod {
  void pay(double amount);
}

class CreditCard extends PaymentMethod {
  @override
  void pay(double amount) => print('Paid \$${amount.toStringAsFixed(2)} via Credit Card.');
}

class PayPal extends PaymentMethod {
  @override
  void pay(double amount) => print('Paid \$${amount.toStringAsFixed(2)} via PayPal.');
}

void processPayment(PaymentMethod method, double amount) {
  method.pay(amount);
}

// Task 5: Data Formatting System
abstract class DataFormatter {
  String format(Map<String, dynamic> data);
}

class JSONFormatter extends DataFormatter {
  @override
  String format(Map<String, dynamic> data) => jsonEncode(data);
}

class KeyValueFormatter extends DataFormatter {
  @override
  String format(Map<String, dynamic> data) {
    return data.entries.map((e) => '${e.key}: ${e.value}').join('\n');
  }
}

void main() {
  // Task 1: Shape Areas
  List<Shape> shapes = [Circle(5.0), Rectangle(4.0, 6.0)];
  for (var shape in shapes) {
    print('A ${shape.runtimeType} has an area of ${shape.area().toStringAsFixed(2)}');
  }

  // Task 2: Weapon Actions
  List<Weapon> weapons = [Sword(), Bow()];
  for (var weapon in weapons) {
    weapon.action();
  }

  // Task 3: Animal Feeder
  feed(Lion());
  feed(Goat());

  // Task 4: Payment Processing
  processPayment(CreditCard(), 150.0);
  processPayment(PayPal(), 75.5);

  // Task 5: Data Formatting
  Map<String, dynamic> sampleData = {
    'name': 'Avazbek',
    'age': 21,
    'language': 'Dart'
  };

  List<DataFormatter> formatters = [JSONFormatter(), KeyValueFormatter()];
  for (var formatter in formatters) {
    print('\n${formatter.runtimeType} Output:\n${formatter.format(sampleData)}');
  }
}
