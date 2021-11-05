import 'dart:convert';
import 'dart:io';

Future<dynamic> _readMockFile(String file) async {
  String directory = Directory.current.path;
  if (directory.endsWith('/test')) {
    directory = directory.replaceAll('/test', '');
  }
  return json
      .decode(File('$directory/test/mocks/json/$file').readAsStringSync());
}

Future<Map<String, dynamic>> jsonToMap(String file) =>
    _readMockFile(file).then((value) => value as Map<String, dynamic>);
