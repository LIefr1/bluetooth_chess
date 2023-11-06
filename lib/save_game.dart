import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class SavedGame {
  final String moves;
  final bool isOnline;
  final String deviceMac;

  SavedGame(
      {required this.isOnline, required this.deviceMac, required this.moves});
}

class SaveGame {
  final _separator = Platform.pathSeparator;
  _getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  _createFile() async {
    var path = await _getPath();
    var file = File('$path${_separator}data.json');
    if (await file.exists()) {
      return file;
    } else {
      await file.create();
      return file;
    }
  }

  saveGame(
      {String fen = "", bool isOnline = false, String deviceMac = ""}) async {
    try {
      File file = await _createFile();
      var data = {"inOnline": isOnline, "fen": fen, "deviceMac": deviceMac};
      print(jsonEncode(data));
      await file.writeAsString(jsonEncode(data));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  loadGame() async {
    try {
      File file = File('${await _getPath()}${_separator}data.json');
      if (file.existsSync()) {}

      var contents = await file.readAsString();
      print(contents.isEmpty);
      var data = json.decode(contents);
      return SavedGame(
          deviceMac: data['deviceMac'],
          isOnline: data['isOnline'],
          moves: data['fen']);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
