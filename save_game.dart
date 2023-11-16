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

class GameDataHeandler {
   final _separator = Platform.pathSeparator;
   // Можно сделать конструктор singleton, но это по вкусу.

   // Эту функцию можно вызывать в конструкторе класса и результат записывать в приватное поле класса. 
  _getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

bool _checkFileExist(File file) {
  return file.exist()
	? true
	: false;
}

  _createFile() async {
    var path = await _getPath();
    var file = File('$path${_separator}data.json');

    return _checkFileExist(file)
	? file
	: file.create();
  }

  saveGame(SavedGame data) async {
    var file = File('${await _getPath()}${_separator}data.json');

    
    if (!_checkFileExist(file)) {
	file.create();
    }

    var data = {"inOnline": isOnline, "fen": fen, "deviceMac": deviceMac};
    
    try{
    	await file.writeAsString(jsonEncode(data));
    }
    on FileSystemException catch (ex) {
    	// Можно сделать логирование.
	throw ex; // Прокидываем ошибку вызывающему коду.
    }
  }

  loadGame() async {
    File file = File('${await _getPath()}${_separator}data.json');
    
    if (_checkFileExist()) {
	throw FileSystemException("Файла не существует");
    }

    try {
      var contents = await file.readAsString();
      var data = json.decode(contents);

      return SavedGame(
          deviceMac: data['deviceMac'],
          isOnline: data['isOnline'],
          moves: data['fen']);
    } 
    on JsonCyclicError catch(ex) {
    	// Можно сделать логирование.
	throw ex; // Прокидываем ошибку вызывающему коду.
    }
    on JsonUnsupportedOnjectError catch (ex) {
    	// Можно сделать логирование.
	throw ex; // Прокидываем ошибку вызывающему коду.
    }
    on FileSystemException catch (ex) {
    	// Можно сделать логирование.
	throw ex; // Прокидываем ошибку вызывающему коду.
    }
  }
}
