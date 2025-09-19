void printAtIndex(List list, int index) {
  try {
    print('Element at $index is: ${list[index]}');
  } on RangeError {
    print('Error: Invalid index.');
  } catch (e) {
    print('Unexpected error: $e');
  }
}

void parseAge(String input) {
  try {
    var age = int.parse(input);
    print('Parsed age: $age');
  } on FormatException {
    print('FormatException: Invalid number format for age.');
  } catch (e) {
    print('Unexpected parse error: $e');
  }
}

class InvalidInputException implements Exception {
  final String message;
  InvalidInputException(this.message);
  @override
  String toString() => 'InvalidInputException: $message';
}

void processText(String text) {
  if (text.trim().isEmpty) throw InvalidInputException('Input text is empty');
  print('Processed text: ${text.trim()}');
}

void simulateDatabaseOperation(bool throwError) {
  try {
    print('Opening connection...');
    if (throwError) throw Exception('Read error');
    print('Read data successfully.');
  } catch (e) {
    print('Caught error: $e');
  } finally {
    print('Database connection closed.');
  }
}