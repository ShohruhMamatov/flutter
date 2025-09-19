
Future<String> reportFuture() {
  return Future.delayed(Duration(seconds: 1), () => 'Report generated!');
}

Future<String> reportAsync() async {
  await Future.delayed(Duration(seconds: 1));
  return 'Report generated!';
}

Future<int> fetchUserId() async {
  await Future.delayed(Duration(seconds: 1));
  return 123;
}

Future<String> fetchUserDetails(int userId) async {
  await Future.delayed(Duration(seconds: 1));
  return 'User#$userId: Alice';
}

Future<Map<String, dynamic>> fetchConfiguration() async {
  await Future.delayed(Duration(seconds: 1));
  return {'config': 'ok'};
}

Future<Map<String, dynamic>> loadResources() async {
  await Future.delayed(Duration(seconds: 2));
  return {'resources': 'ready'};
}
