import 'package:bluetoth_chess/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<BluetoothController>(
            init: BluetoothController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: Colors.blue,
                      child: const Center(child: Text("Connect bluetooth")),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => controller.scanDevices(),
                        child: const Text("Scan"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<List<ScanResult>>(
                      stream: controller.scanResults,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];
                              return Card(
                                elevation: 2,
                                child: ListTile(
                                  title: Text(data.device.platformName),
                                  subtitle: Text(data.device.remoteId.str),
                                  trailing: Text(data.rssi.toString()),
                                  onTap: () {
                                    controller.connectDevice(data.device);
                                  },
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Card(
                              elevation: 2,
                              child: Text("No devices found"),
                            ),
                          );
                        }
                      },
                    ),
                    if (controller.selectedDevice != null)
                      ElevatedButton(
                        onPressed: () {
                          controller.disconnectFromDevice();
                        },
                        child: const Text("Disconnect"),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
