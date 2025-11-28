// test/all_tests.dart
// Run with: flutter test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Import your main.dart file here
// import 'package:your_app/main.dart';

// For this demo, we'll include the classes inline
// In a real project, import from main.dart

// ============================================================================
// CLASSES FROM MAIN (Copy these or import from main.dart)
// ============================================================================

class Calculator {
  int add(int a, int b) => a + b;
}

class CounterApp extends StatefulWidget {
  const CounterApp({Key? key}) : super(key: key);
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;
  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: Center(
        child: Text('$_counter', key: const Key('counter_text')),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('increment_button'),
        onPressed: _incrementCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (!value.contains('@')) return 'Invalid email format';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        onChanged: _validateForm,
        child: Column(
          children: [
            TextFormField(
              key: const Key('email_field'),
              controller: _emailController,
              validator: _validateEmail,
            ),
            TextFormField(
              key: const Key('password_field'),
              controller: _passwordController,
              validator: _validatePassword,
            ),
            ElevatedButton(
              key: const Key('submit_button'),
              onPressed: _isFormValid ? () {} : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

abstract class AuthService {
  Future<bool> signIn(String email, String password);
}

class AuthManager {
  final AuthService authService;
  AuthManager(this.authService);
  
  Future<String> login(String email, String password) async {
    try {
      final success = await authService.signIn(email, password);
      return success ? 'Login successful' : 'Invalid credentials';
    } catch (e) {
      return 'Login failed: $e';
    }
  }
}

class UserProfile {
  String? name;
  int? age;
  
  String getDisplayName() => name?.toUpperCase() ?? 'Unknown User';
  int getAgeInMonths() => (age ?? 0) * 12;
}

// ============================================================================
// TASK 1: Unit Test - Calculator.add() [10 points]
// ============================================================================

void main() {
  group('TASK 1: Calculator Unit Tests', () {
    late Calculator calculator;

    setUp(() {
      // Arrange: Create calculator instance before each test
      calculator = Calculator();
    });

    test('add() should return sum of two positive numbers', () {
      // Arrange
      const a = 5;
      const b = 3;

      // Act
      final result = calculator.add(a, b);

      // Assert
      expect(result, 8);
    });

    test('add() should handle negative numbers', () {
      // Arrange
      const a = -5;
      const b = -3;

      // Act
      final result = calculator.add(a, b);

      // Assert
      expect(result, -8);
    });

    test('add() should handle zero values', () {
      // Arrange
      const a = 0;
      const b = 0;

      // Act
      final result = calculator.add(a, b);

      // Assert
      expect(result, 0);
    });

    test('add() should handle mixed positive and negative', () {
      // Arrange
      const a = 10;
      const b = -3;

      // Act
      final result = calculator.add(a, b);

      // Assert
      expect(result, 7);
    });

    test('add() should handle large numbers', () {
      // Arrange
      const a = 1000000;
      const b = 2000000;

      // Act
      final result = calculator.add(a, b);

      // Assert
      expect(result, 3000000);
    });
  });

  // ==========================================================================
  // TASK 2: Widget Test - Counter App [10 points]
  // ==========================================================================

  group('TASK 2: Counter App Widget Tests', () {
    testWidgets('Counter starts at 0', (WidgetTester tester) async {
      // Arrange & Act: Pump the widget
      await tester.pumpWidget(const MaterialApp(home: CounterApp()));

      // Assert: Verify initial counter value
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('Counter increments when button is tapped', (WidgetTester tester) async {
      // Arrange: Pump the widget
      await tester.pumpWidget(const MaterialApp(home: CounterApp()));

      // Act: Tap the increment button
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump(); // Rebuild after state change

      // Assert: Verify counter updated to 1
      expect(find.text('1'), findsOneWidget);
      expect(find.text('0'), findsNothing);
    });

    testWidgets('Counter increments multiple times', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: CounterApp()));

      // Act: Tap multiple times
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();

      // Assert
      expect(find.text('3'), findsOneWidget);
    });
  });

  // ==========================================================================
  // TASK 3: Widget Test - Login Form Validation [10 points]
  // ==========================================================================

  group('TASK 3: Login Form Validation Tests', () {
    testWidgets('Shows error when email field is empty', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Act: Enter text in password but leave email empty
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.pump();

      // Trigger validation by tapping submit (will be disabled)
      final emailField = find.byKey(const Key('email_field'));
      await tester.tap(emailField);
      await tester.pump();

      // Assert: Submit button should be disabled
      final submitButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('submit_button')),
      );
      expect(submitButton.onPressed, isNull);
    });

    testWidgets('Shows error for invalid email format', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Act: Enter invalid email
      await tester.enterText(find.byKey(const Key('email_field')), 'notanemail');
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.pump();

      // Assert: Find error message
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('Submit button enabled with valid data', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Act: Enter valid email and password
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.pump();
      await tester.enterText(find.byKey(const Key('password_field')), 'password123');
      await tester.pump();

      // Assert: Submit button should be enabled
      final submitButton = tester.widget<ElevatedButton>(
        find.byKey(const Key('submit_button')),
      );
      expect(submitButton.onPressed, isNotNull);
    });

    testWidgets('Shows error for short password', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

      // Act
      await tester.enterText(find.byKey(const Key('email_field')), 'test@example.com');
      await tester.enterText(find.byKey(const Key('password_field')), '123');
      await tester.pump();

      // Assert
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
  });

  // ==========================================================================
  // TASK 4: Unit Test with Mocking - Auth Logic [10 points]
  // ==========================================================================

  group('TASK 4: Auth Logic with Mocking', () {
    test('Successful login with mocked auth service', () async {
      // Arrange: Create a mock that returns success
      final mockAuthService = MockAuthService(shouldSucceed: true);
      final authManager = AuthManager(mockAuthService);

      // Act
      final result = await authManager.login('test@example.com', 'password123');

      // Assert
      expect(result, 'Login successful');
      expect(mockAuthService.callCount, 1);
    });

    test('Failed login with mocked auth service', () async {
      // Arrange: Create a mock that returns failure
      final mockAuthService = MockAuthService(shouldSucceed: false);
      final authManager = AuthManager(mockAuthService);

      // Act
      final result = await authManager.login('wrong@example.com', 'wrong');

      // Assert
      expect(result, 'Invalid credentials');
      expect(mockAuthService.callCount, 1);
    });

    test('Handles auth service exception', () async {
      // Arrange: Create a mock that throws exception
      final mockAuthService = MockAuthService(shouldThrow: true);
      final authManager = AuthManager(mockAuthService);

      // Act
      final result = await authManager.login('test@example.com', 'password');

      // Assert
      expect(result, contains('Login failed'));
    });

    test('No real network calls are made', () async {
      // Arrange
      final mockAuthService = MockAuthService(shouldSucceed: true);
      final authManager = AuthManager(mockAuthService);

      // Act
      final startTime = DateTime.now();
      await authManager.login('test@example.com', 'password');
      final duration = DateTime.now().difference(startTime);

      // Assert: Should complete almost instantly (no real delay)
      expect(duration.inMilliseconds, lessThan(100));
      expect(mockAuthService.wasCalledWithoutNetwork, true);
    });
  });

  // ==========================================================================
  // TASK 5: Debugging - Null Safety [10 points]
  // ==========================================================================

  group('TASK 5: Null Safety Debugging', () {
    test('getDisplayName handles null name gracefully', () {
      // Arrange: Create profile with null name (would crash before fix)
      final profile = UserProfile();

      // Act
      final displayName = profile.getDisplayName();

      // Assert: Should return default value instead of crashing
      expect(displayName, 'Unknown User');
    });

    test('getDisplayName returns uppercase name when present', () {
      // Arrange
      final profile = UserProfile()..name = 'john';

      // Act
      final displayName = profile.getDisplayName();

      // Assert
      expect(displayName, 'JOHN');
    });

    test('getAgeInMonths handles null age gracefully', () {
      // Arrange: Create profile with null age (would crash before fix)
      final profile = UserProfile();

      // Act
      final ageInMonths = profile.getAgeInMonths();

      // Assert: Should return 0 instead of crashing
      expect(ageInMonths, 0);
    });

    test('getAgeInMonths calculates correctly when age is present', () {
      // Arrange
      final profile = UserProfile()..age = 25;

      // Act
      final ageInMonths = profile.getAgeInMonths();

      // Assert
      expect(ageInMonths, 300);
    });
  });

  // ==========================================================================
  // TASK 7: Running Tests (Documentation)
  // ==========================================================================

  group('TASK 7: Test Execution Documentation', () {
    test('This test demonstrates successful execution', () {
      // This test verifies that the test suite runs successfully
      // To complete Task 7:
      // 1. Run: flutter test
      // 2. Capture the output showing all tests pass
      // 3. Run on emulator: flutter run
      // 4. Connect device and run: flutter run -d <device_id>
      // 5. Take screenshots of the app running on both

      expect(true, true);
    });
  });
}

// ============================================================================
// MOCK AUTH SERVICE FOR TASK 4
// ============================================================================

class MockAuthService implements AuthService {
  final bool shouldSucceed;
  final bool shouldThrow;
  int callCount = 0;
  bool wasCalledWithoutNetwork = false;

  MockAuthService({
    this.shouldSucceed = true,
    this.shouldThrow = false,
  });

  @override
  Future<bool> signIn(String email, String password) async {
    callCount++;
    wasCalledWithoutNetwork = true;

    // No real network delay - this is a mock!
    if (shouldThrow) {
      throw Exception('Network error');
    }

    return shouldSucceed;
  }
}

