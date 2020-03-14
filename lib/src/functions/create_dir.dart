import 'dart:io';
import 'package:dshell/dshell.dart';

import 'function.dart';
import '../settings.dart';

/// Creates a directory as described by [path].
/// Path may be a single path segment (e.g. bin)
/// or a full or partial tree (e.g. /usr/bin)
///
/// ```dart
/// createDir("/tmp/fred/tools", recursive=true);
/// ```
///
/// If [recursive] is true then any parent
/// paths that don't exist will be created.
///
/// If [recursive] is false then any parent paths
/// don't exist then a [CreateDirException] will be thrown.
///
/// If the [path] already exists an exception is thrown.
///

void createDir(String path, {bool recursive = false}) =>
    CreateDir().createDir(path, recursive: recursive);

class CreateDir extends DShellFunction {
  void createDir(String path, {bool recursive}) {
    Settings().verbose('createDir:  ${absolute(path)} recursive: $recursive');

    try {
      if (exists(path)) {
        throw CreateDirException('The path ${absolute(path)} already exists');
      }

      Directory(path).createSync(recursive: recursive);
    } catch (e) {
      throw CreateDirException(
          'Unable to create the directory ${absolute(path)}. Error: ${e}');
    }
  }
}

class CreateDirException extends FunctionException {
  CreateDirException(String reason) : super(reason);
}
