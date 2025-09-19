// Task 1: Vehicle and Car
class Vehicle {
  String model;

  Vehicle(this.model);

  void display() {
    print('Vehicle: $model');
  }
}

class Car extends Vehicle {
  int numberOfDoors;

  Car(String model, this.numberOfDoors) : super(model);

  @override
  void display() {
    super.display();
    print('Doors: $numberOfDoors');
  }
}

// Task 2: Animal Sounds
class Animal {
  void makeSound() {
    print('Some generic animal sound');
  }
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Woof!');
  }
}

class Cat extends Animal {
  @override
  void makeSound() {
    print('Meow!');
  }
}

// Task 3: Shape Hierarchy
class Shape {
  String color;

  Shape(this.color);
}

class Circle extends Shape {
  double radius;

  Circle(String color, this.radius) : super(color);
}

class Square extends Shape {
  double side;

  Square(String color, this.side) : super(color);
}

// Task 4: Employee and Manager
class Employee {
  String name;
  double baseSalary;

  Employee(this.name, this.baseSalary);

  double calculateSalary() => baseSalary;
}

class Manager extends Employee {
  double bonus;

  Manager(String name, double baseSalary, this.bonus) : super(name, baseSalary);

  @override
  double calculateSalary() => baseSalary + bonus;
}

// Task 5: Library Items
class LibraryItem {
  String title;
  String id;

  LibraryItem(this.title, this.id);

  String getDetails() => 'Title: $title, ID: $id';
}

class Book extends LibraryItem {
  String author;

  Book(String title, String id, this.author) : super(title, id);

  @override
  String getDetails() => 'Book → Title: $title, Author: $author, ID: $id';
}

class DVD extends LibraryItem {
  String director;

  DVD(String title, String id, this.director) : super(title, id);

  @override
  String getDetails() => 'DVD → Title: $title, Director: $director, ID: $id';
}

void main() {
  // Task 1: Vehicle and Car
  var car = Car('Honda', 4);
  car.display();

  // Task 2: Animal Sounds
  var dog = Dog();
  var cat = Cat();
  dog.makeSound();
  cat.makeSound();

  // Task 3: Shape Hierarchy
  var circle = Circle('Red', 5.0);
  var square = Square('Blue', 4.0);
  print('Circle → Color: ${circle.color}, Radius: ${circle.radius}');
  print('Square → Color: ${square.color}, Side: ${square.side}');

  // Task 4: Employee and Manager
  var emp = Employee('Ali', 1000.0);
  var mgr = Manager('Avazbek', 1000.0, 500.0);
  print('${emp.name} Salary: \$${emp.calculateSalary()}');
  print('${mgr.name} Salary: \$${mgr.calculateSalary()}');

  // Task 5: Library Items
  var book = Book('Clean Code', 'B001', 'Robert C. Martin');
  var dvd = DVD('Inception', 'D001', 'Christopher Nolan');
  print(book.getDetails());
  print(dvd.getDetails());
}
