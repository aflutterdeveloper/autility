import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as Crypto;

class AMD5 {
  static String md5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = Crypto.md5.convert(content);
    return hex.encode(digest.bytes);
  }
}