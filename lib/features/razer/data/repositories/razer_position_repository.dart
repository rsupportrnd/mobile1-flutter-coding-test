import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../sensor/data/models/sensor_rotation.dart';

class RazerPositionRepository with ChangeNotifier {
  late ServerSocket socket;
  double x = 0;
  double y = 0;
  double maxX = 0;
  double maxY = 0;

  RazerPositionRepository();

  Future<void> init() async {
    await connect();
    listenSocket();
  }

  Future<void> connect() async {
    socket = await ServerSocket.bind(InternetAddress.anyIPv4, 8080);
  }

  void disconnect() {
    socket.close();
  }

  void listenSocket() {
    socket.listen((Socket client) {
      client.listen((bytes) {
        fetchRotationData(bytes);
      });
    });
  }

  void updateXY(double dx, double dy) {
    x = (x + dx).clamp(-maxX, maxX);
    y = (y + dy).clamp(-maxY, maxY);

    notifyListeners();
  }

  void fetchRotationData(Uint8List bytes) {
    String str = String.fromCharCodes(bytes);
    Map<String, dynamic> json = jsonDecode(str);
    SensorRotation rotation = SensorRotation.fromJson(json);

    updateXY(rotation.x * 2, rotation.y * 2);
  }

  void setMax(x, y) {
    maxX = x / 2 - 10;
    maxY = y / 2 - 10;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
  }
}
