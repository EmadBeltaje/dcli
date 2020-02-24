@Timeout(Duration(seconds: 600))
import 'package:dshell/src/pubspec/pubspec_annotation.dart';
import 'package:test/test.dart';

import '../util/test_file_system.dart';

void main() {
  test('parse', () {
    TestFileSystem().withinZone((fs) {
      var annotation = '''
    /*
      @pubspec
      name: find.dart
      dependencies:
        dshell: ^1.0.0
        args: ^1.5.2
        path: ^1.6.4
    */
    ''';

      PubSpecAnnotation.fromString(annotation);
    });
  });
}
