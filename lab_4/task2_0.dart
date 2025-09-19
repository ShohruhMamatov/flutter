// Task 1: DaysOfWeek Enum
enum DaysOfWeek { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

void checkDay(DaysOfWeek day) {
  switch (day) {
    case DaysOfWeek.saturday:
    case DaysOfWeek.sunday:
      print('$day is on the weekend.');
      break;
    default:
      print('$day is a weekday.');
  }
}

// Task 2: OrderStatus Enum
enum OrderStatus { pending, processing, shipped, delivered, canceled }

// Task 3: TrafficLight Enum with Action
enum TrafficLight { red, yellow, green }

String getTrafficAction(TrafficLight light) {
  switch (light) {
    case TrafficLight.red:
      return 'Stop';
    case TrafficLight.yellow:
      return 'Caution';
    case TrafficLight.green:
      return 'Go';
  }
}

// Task 4: UserRole Enum + User Class
enum UserRole { admin, editor, guest }

class User {
  String name;
  UserRole role;

  User(this.name, this.role);

  bool hasEditPermission() {
    return role == UserRole.admin || role == UserRole.editor;
  }
}

// Task 5: TrafficLight Enum with Duration
extension TrafficLightDuration on TrafficLight {
  int get durationInSeconds {
    switch (this) {
      case TrafficLight.red:
        return 30;
      case TrafficLight.yellow:
        return 5;
      case TrafficLight.green:
        return 45;
    }
  }
}

void main() {
  // Task 1: DaysOfWeek
  checkDay(DaysOfWeek.monday);
  checkDay(DaysOfWeek.saturday);

  // Task 2: OrderStatus
  OrderStatus status = OrderStatus.processing;
  print('Order status: $status');

  // Task 3: TrafficLight Actions
  for (var light in TrafficLight.values) {
    print('Light: $light → Action: ${getTrafficAction(light)}');
  }

  // Task 4: User Roles
  var user1 = User('Avazbek', UserRole.admin);
  var user2 = User('Ali', UserRole.guest);
  print('${user1.name} has edit permission: ${user1.hasEditPermission()}');
  print('${user2.name} has edit permission: ${user2.hasEditPermission()}');

  // Task 5: TrafficLight Durations
  for (var light in TrafficLight.values) {
    print('Light: $light → Duration: ${light.durationInSeconds} seconds');
  }
}
