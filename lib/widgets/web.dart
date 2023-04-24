import 'dart:convert';

import 'package:universal_html/html.dart';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  AnchorElement(
      href:
          "data:aplication/octet-stream;charset-utf-16le;base64${base64.encode(bytes)}")
    ..setAttribute("dowloand", fileName)
    ..click();
}
