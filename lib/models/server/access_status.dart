import 'dart:async';
import 'dart:io';

import 'package:admin/services/logger.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AccessStatus {
  final int id;
  final String label;
  final Color bgColor;
  final IconData icon;

  AccessStatus({
    this.id = 0,
    this.label = '',
    this.bgColor = Colors.indigo,
    this.icon = FeatherIcons.home,
  });

  static final statusList = [
    AccessStatus(
      id: 1,
      label: 'Server Status',
      icon: FeatherIcons.server,
      bgColor: Colors.indigo.shade50,
    ),
    AccessStatus(
      id: 2,
      label: 'API Status',
      icon: FeatherIcons.layers,
      bgColor: Colors.indigo.shade50,
    ),
    AccessStatus(
      id: 3,
      label: 'Site Status',
      icon: FeatherIcons.layout,
      bgColor: Colors.indigo.shade50,
    ),
  ];

  static Future<void> checkServerStatus({
    required Function onStart,
    required Function(bool) onComplete,
  }) async {
    onStart();
    logInfo('checking server status...');
    final dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    final response = await dio.get('https://layground.id/aapanel/demo.php');
    // logInfo(response.data);
    onComplete(response.statusCode == 200);
  }

  static Future<void> checkAPIStatus({
    required Function onStart,
    required Function(bool) onComplete,
  }) async {
    onStart();
    logInfo('checking api status...');
    final dio = Dio();
    final response = await dio.get('https://panel.dapurlestari.id/api/homepage');
    // logInfo(response.data);
    onComplete(response.statusCode == 200);
  }

  static Future<void> checkSiteStatus({
    required Function onStart,
    required Function(bool) onComplete,
  }) async {
    onStart();
    logInfo('checking site status...');
    final dio = Dio();
    final response = await dio.get('https://dapurlestari.id');
    // logInfo(response.statusCode);
    onComplete(response.statusCode == 200);
  }
}