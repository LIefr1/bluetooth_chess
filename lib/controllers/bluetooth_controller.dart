import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;

  Future<void> scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice = device;
      // Perform any actions after successful connection

      // Discover services and characteristics
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        List<BluetoothCharacteristic> characteristics = service.characteristics;
        for (BluetoothCharacteristic characteristic in characteristics) {
          // Check if the characteristic supports write operations
          if (characteristic.properties.write) {
            this.characteristic = characteristic;
            break;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void disconnectFromDevice() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
    characteristic = null;
  }

  Future<void> sendData(List<int> data) async {
    if (connectedDevice != null && characteristic != null) {
      await characteristic!.write(data, withoutResponse: true);
    }
  }

  Future<List<int>> reciveData() async {
    if (connectedDevice != null && characteristic != null) {
      var data = await characteristic!.read();
      print(data);
      return data;
    } else {
      return List.empty();
    }
  }

  Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;
  BluetoothDevice? get selectedDevice => connectedDevice;
}
