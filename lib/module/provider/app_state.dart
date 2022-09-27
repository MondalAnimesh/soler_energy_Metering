import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:solar_energy/module/data/devices.dart';
import 'package:solar_energy/module/data/user_data.dart';

class Appstate extends ChangeNotifier {
  Userdata user = Userdata(
      userName: TextEditingController(),
      phoneNumber: TextEditingController(),
      password: TextEditingController(),
      plantDetails: TextEditingController(),
      address: TextEditingController());
  Devices devices = Devices();
  bool isMqttConnected = false;
  MqttServerClient client =
      MqttServerClient.withPort('192.168.10.99', 'flutter_client', 1883);
  updateUserData() async {
    await user.fetchdata();
    notifyListeners();
  }

  updateDevices() async {
    devices.devices.clear();
    if (!isMqttConnected) {
      await connectMqtt();
    }
    await devices.fetchid();
    for (var x in devices.devices) {
      subscribeTopic(x.id.toString());
    }
    notifyListeners();
  }

// connection succeeded
  void onConnected() {
    isMqttConnected = true;
    EasyLoading.showInfo('Connected');
    notifyListeners();
  }

// unconnected
  void onDisconnected() {
    isMqttConnected = false;
    EasyLoading.showError('Disconnected');
    notifyListeners();
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    // EasyLoading.showInfo('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    //  EasyLoading.showError('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    EasyLoading.showInfo('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    EasyLoading.showError('Ping response client callback invoked');
  }

  subscribeTopic(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  TextEditingController txt = TextEditingController();
  String lastmsg = "No data available";

  connectMqtt() async {
    client = MqttServerClient.withPort(
        'ecbroker.thekaspertech.com', 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs("Animesh", "")
        .withWillTopic('/test')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
    try {
      await client.connect();
    } catch (e) {
      debugPrint('Exception: $e');
      client.disconnect();
    }

    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) async {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      lastmsg = pt;
      notifyListeners();
      debugPrint(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      var data = await jsonDecode(pt);
      devices.devices[devices.devices
              .indexWhere((element) => element.id == data['id'])] =
          Device(
              id: data['id'].toString(),
              current: data['current'],
              volt: data['volt'],
              power: data['power'],
              energy: data['energy']);
      notifyListeners();
      debugPrint('');
    });
  }
}
