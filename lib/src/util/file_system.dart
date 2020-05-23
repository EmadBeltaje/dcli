import 'dart:io';

import '../../dshell.dart';

/// Returns the amount of space (in bytes) available on the disk
/// that [path] exists on.
int availableSpace(String path) {
  if (!exists(path)) {
    throw FileSystemException(
        "The given path ${truepath(path)} doesn't exists");
  }

  var lines = 'df -h "$path"'.toList();
  if (lines.length != 2) {
    throw FileSystemException(
        "An error occured retrieving the device path: ${lines.join('\n')}");
  }

  var line = lines[1];
  var parts = line.split(RegExp(r'\s+'));

  if (parts.length != 6) {
    throw FileSystemException('An error parsing line: $line');
  }

  var factors = {'G': 1000000000, 'M': 1000000, 'K': 1000, 'B': 1};

  var havailable = parts[3];

  if (havailable == '0') return 0;

  var factoryLetter = havailable.substring(havailable.length - 1);
  var hsize = havailable.substring(0, havailable.length - 1);

  var factor = factors[factoryLetter];
  if (factor == null) {
    throw FileSystemException(
        "Unrecognized size factor '$factoryLetter' in $havailable");
  }

  return int.tryParse(hsize) * factor;
}

/// returns the the number [bytes] in a human readable
/// form. e.g. 10G, 100M, 20K, 10B
String humanNumber(int bytes) {
  String human;

  var svalue = '$bytes';
  if (bytes > 1000000000) {
    human = svalue.substring(0, svalue.length - 9);
    human += 'G';
  } else if (bytes > 1000000) {
    human = svalue.substring(0, svalue.length - 6);
    human += 'M';
  } else if (bytes > 1000) {
    human = svalue.substring(0, svalue.length - 3);
    human += 'K';
  } else {
    human = '${svalue}B';
  }
  return human;
}
