import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';
import 'package:solar_energy/module/provider/app_state.dart';

class Mqtt extends StatefulWidget {
  const Mqtt({super.key});

  @override
  State<Mqtt> createState() => _MqttState();
}

class _MqttState extends State<Mqtt> {
  Future<MqttServerClient> connect() async {
    MqttServerClient client =
        MqttServerClient.withPort('192.168.10.99', 'flutter_client', 1883);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onUnsubscribed = onUnsubscribed;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    final connMessage = MqttConnectMessage()
        .authenticateAs('Premchand', 'prem')
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
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      lastmsg = pt;
      setState(() {});
      debugPrint(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      debugPrint('');
    });
    return client;
  }

// connection succeeded
  void onConnected() {
    EasyLoading.showInfo('Connected');
  }

// unconnected
  void onDisconnected() {
    EasyLoading.showError('Disconnected');
  }

// subscribe to topic succeeded
  void onSubscribed(String topic) {
    EasyLoading.showInfo('Subscribed topic: $topic');
  }

// subscribe to topic failed
  void onSubscribeFail(String topic) {
    EasyLoading.showError('Failed to subscribe $topic');
  }

// unsubscribe succeeded
  void onUnsubscribed(String? topic) {
    EasyLoading.showInfo('Unsubscribed topic: $topic');
  }

// PING response received
  void pong() {
    EasyLoading.showError('Ping response client callback invoked');
  }

  MqttServerClient? client;
  TextEditingController txt = TextEditingController();
  String lastmsg = "No data available";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conn();
  }

  conn() async {
    client = await connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<Appstate>(builder: (context, value, child) {
      return ListView(padding: const EdgeInsets.all(20), children: [
        Card(
          elevation: 2,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
            child: const Text(
              "hello",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Card(
          elevation: 2,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
        ),
        Card(
          elevation: 2,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
        ),
        Card(
          elevation: 2,
          child: Container(
            height: 100,
            width: 100,
            color: Colors.white,
          ),
        )
      ]);
    }));
  }
}
