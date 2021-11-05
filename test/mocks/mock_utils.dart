import 'dart:convert';
import 'dart:io';

Future<dynamic> _readMockFile(String jsonPath) async {
  String directory = Directory.current.path;
  if (directory.endsWith('/test')) {
    directory = directory.replaceAll('/test', '');
  }
  return json
      .decode(File('$directory/test/mocks/json/$jsonPath').readAsStringSync());
}

Future<Map<String, dynamic>> jsonToMap(String jsonPath) =>
    _readMockFile(jsonPath).then((value) => value as Map<String, dynamic>);
