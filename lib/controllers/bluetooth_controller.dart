import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  BluetoothDevice? connectedDevice;

  Future<void> scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      print('Connected to ${device.platformName}');
      // Perform any actions after successful connection
    } catch (e) {
      print('Failed to connect to ${device.platformName}: $e');
    }
  }

  void disconnectFromDevice() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  BluetoothDevice? get selectedDevice => connectedDevice;
}
