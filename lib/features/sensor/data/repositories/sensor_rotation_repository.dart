import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/sensor_rotation.dart';

class SensorRotationRepository with ChangeNotifier {
  static const EventChannel eventChannel =
      EventChannel('flutter/rotation/stream');
  static const ip = '192.168.45.205';
  static const port = 8080;
  late Socket socket;

  Future<void> connect() async {
    socket = await Socket.connect(ip, port);
  }

  void disconnect() {
    socket.destroy();
  }

  void send(data) {
    SensorRotation rotation = SensorRotation(x: data[0], y: data[1]);

    socket.write(jsonEncode(rotation.toJson()));
  }

  void stream() async {
    await connect();
    eventChannel.receiveBroadcastStream().listen((dynamic data) {
      send(data);
    }, onError: (dynamic error) {
      debugPrint('Error: $error');
    });
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
  }
}
