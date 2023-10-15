import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothConroller extends GetxController {
  Future scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    // FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
}
