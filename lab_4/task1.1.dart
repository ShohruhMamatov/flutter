class Car {
  String make;
  String model;
  int year;

  Car(this.make, this.model, this.year);

  void displayInfo() {
    print('Car Information: $year $make $model');
  }
}
