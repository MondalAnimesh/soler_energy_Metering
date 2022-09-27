import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:solar_energy/module/provider/app_state.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Appstate>(builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text(
                "Dashboard",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                    onPressed: value.connectMqtt,
                    icon: const Icon(
                      Icons.connect_without_contact,
                      color: Colors.black,
                    )),
                PopupMenuButton(
                  offset: const Offset(0.0, 60.0),
                  icon: const Icon(Icons.account_circle_sharp,
                      color: Colors.black),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                    PopupMenuItem<String>(
                      onTap: value.updateDevices,
                      child: const Center(child: Text("Refresh")),
                    ),
                  ],
                ),
              ]),
          body: ListView(padding: const EdgeInsets.all(20), children: [
            for (var i in value.devices.devices)
              Card(
                elevation: 2,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        i.id.toString(),
                        style: const TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Text(
                            i.current ?? "--",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            i.volt ?? "--",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            i.power ?? "--",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            i.energy ?? "--",
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
          ]));
    });
  }
}
