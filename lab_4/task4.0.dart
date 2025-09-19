// Task 1: Swimmer Mixin
mixin Swimmer {
  void swim() {
    print('Swimming through the water...');
  }
}

class Human {
  String name;
  Human(this.name);
}

class Fish {
  String species;
  Fish(this.species);
}

class Alice extends Human with Swimmer {
  Alice(super.name);
}
class Tuna extends Fish with Swimmer {
  Tuna(String s) : super('');
}

// Task 2: Flyer Mixin
mixin Flyer {
  void fly() {
    print('Taking off!');
  }
}

class Bird with Flyer {}
class Plane with Flyer {}

// Task 3: Logger Mixin
mixin Logger {
  void log(String message) {
    print('[LOG]: $message');
  }
}

class DataService with Logger {
  void fetchData() {
    log('Fetching data...');
  }
}

// Task 4: Validator Mixin
mixin Validator {
  bool isEmailValid(String email) => email.contains('@');
  bool isPasswordStrong(String password) => password.length >= 8;
}

class UserSignup with Validator {
  void validate(String email, String password) {
    print('Email valid: ${isEmailValid(email)}');
    print('Password strong: ${isPasswordStrong(password)}');
  }
}

// Task 5: Combining Mixins
mixin Performer {
  void perform() {
    print('Performing on stage...');
  }
}

mixin Musician {
  void playInstrument() {
    print('Playing guitar...');
  }
}

class Artist {
  String name;
  Artist(this.name);
}

class Dancer extends Artist with Performer {
  Dancer(String name) : super(name);
}

class Guitarist extends Artist with Performer, Musician {
  Guitarist(String name) : super(name);
}

void main() {
  // Task 1: Swimmer
  var alice = Alice('Alice');
  var tuna = Tuna('Tuna');
  alice.swim();
  tuna.swim();

  // Task 2: Flyer
  var bird = Bird();
  var plane = Plane();
  bird.fly();
  plane.fly();

  // Task 3: Logger
  var service = DataService();
  service.fetchData();

  // Task 4: Validator
  var signup = UserSignup();
  signup.validate('avazbek@example;com', 'password123');
}