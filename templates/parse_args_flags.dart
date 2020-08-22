#! /usr/bin/env dcli

/// remove the next line
/// ignore_for_file: unused_import

/*
@pubspec
name: hello_world.dart
dependencies:
  dcli: ^1.0.0
  args: ^1.5.2
  path: ^1.6.4
*/

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;
import 'package:args/args.dart';

///
/// Call this program using:
/// dcli parse_args_flags.dart -v --name test and some more args
///
void main(List<String> args) {
  var parser = ArgParser();

  parser
    ..addFlag('verbose', abbr: 'v')
    ..addOption('name', abbr: 'n');

  var results = parser.parse(args);

  print(results['verbose']);
  print(results['name']);

  // print remaining cmd line args.
  print(results.rest);

  print(parser.usage);
}
