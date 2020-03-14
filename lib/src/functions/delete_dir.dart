import 'dart:io';
import 'function.dart';

import '../settings.dart';

import 'is.dart';

///
/// Deletes the directory located at [path].
///
/// If [recursive] is true then the directory and all child files
/// and directories will be deleted.
///
/// ```dart
/// deleteDir("/tmp/testing", recursive=true);
/// ```
///
/// If [path] is not a directory then a [DeleteDirException] is thrown.
///
/// If the directory does not exists a [DeleteDirException] is thrown.
///
/// If the directory cannot be delete (e.g. permissions) a [DeleteDirException] is thrown.
///
/// If recursive is false the directory must be empty otherwise a [DeleteDirException] is thrown.
///
/// See [isDirectory]
///     [exists]
///
void deleteDir(String path, {bool recursive = true}) =>
    DeleteDir().deleteDir(path, recursive: recursive);

class DeleteDir extends DShellFunction {
  void deleteDir(String path, {bool recursive}) {
    Settings().verbose('deleteDir:  ${absolute(path)} recursive: $recursive');

    if (!exists(path)) {
      throw DeleteDirException('The path ${absolute(path)} does not exist.');
    }

    if (!isDirectory(path)) {
      throw DeleteDirException(
          'The path ${absolute(path)} is not a directory.');
    }

    try {
      Directory(path).deleteSync(recursive: recursive);
    } catch (e) {
      throw DeleteDirException(
          'Unable to delete the directory ${absolute(path)}. Error: $e');
    }
  }
}

class DeleteDirException extends FunctionException {
  DeleteDirException(String reason) : super(reason);
}
