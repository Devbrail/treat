import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final Future<String> _cacheDirFuture = (() async {
  String cacheDir =
      (await getTemporaryDirectory()).path + '/flutter_pdf_viewer';
  await Directory(cacheDir).create();

  return cacheDir;
})();

Future<bool> _fileIsInvalid(File file) async {
  return (await file.stat()).type == FileSystemEntityType.notFound;
}

Future<String> downloadAsFile(String url, {bool cache: true}) async {
  print("Downlonfing gile from serce $url");
  String filepath =
      '${await _cacheDirFuture}/${sha1.convert(utf8.encode(url))}';
  File file = File(filepath);

  if (!cache || await _fileIsInvalid(file)) {
    await file.writeAsBytes(await http.readBytes(Uri.parse(url)));
  }

  return filepath;
}

Future<Uint8List> downloadAsBytes(String url) {
  return http.readBytes(Uri.parse(url));
}
