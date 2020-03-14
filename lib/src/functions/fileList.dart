import 'dart:io';

import 'function.dart';

import '../settings.dart';

import 'pwd.dart';

///
/// returns the list of files and directories
/// in the current directory.
///
/// See [find] for more advanced options when obtain a file list.
List<String> get fileList => FileList().fileList;

class FileList extends DShellFunction {
  List<String> get fileList {
    var files = <String>[];

    Settings().verbose('fileList pwd: ${absolute(pwd)}');

    Directory.current.listSync().forEach((file) => files.add(file.path));
    return files;
  }
}
