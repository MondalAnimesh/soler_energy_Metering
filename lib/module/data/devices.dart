import 'package:flutter/cupertino.dart';
import 'package:solar_energy/module/constants/apis.dart';
import 'package:solar_energy/module/data/http_response.dart';
import 'package:solar_energy/module/http/get_http.dart';

class Device {
  String id;
  String? power;
  String? energy;
  String? volt;
  String? current;
  Device({required this.id, this.current, this.energy, this.power, this.volt});
}

class Devices {
  List<Device> devices = [];
  Devices();
  fetchid() async {
    HttpResponse response = await getrequest(Apis().api + Routes().getdevice);
    debugPrint("${response.data}");
    if (response.status == false) {
      return;
    }
    for (var x in response.data["devices"]) {
      devices.add(Device(id: "${x['deviceID']}"));
    }
    return;
  }
}
