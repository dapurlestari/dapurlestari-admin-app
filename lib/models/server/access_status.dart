import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class AccessStatus {
  final int id;
  final String label;
  final Color bgColor;
  final IconData icon;
  bool healthy;

  AccessStatus({
    this.id = 0,
    this.label = '',
    this.bgColor = Colors.indigo,
    this.icon = FeatherIcons.home,
    this.healthy = false
  });

  static final statusList = [
    AccessStatus(
      id: 1,
      label: 'Server Status',
      icon: FeatherIcons.server,
      bgColor: Colors.indigo.shade50,
      healthy: false,
    ),
    AccessStatus(
      id: 2,
      label: 'API Status',
      icon: FeatherIcons.layers,
      bgColor: Colors.indigo.shade50,
      healthy: false,
    ),
    AccessStatus(
      id: 3,
      label: 'Site Status',
      icon: FeatherIcons.layout,
      bgColor: Colors.indigo.shade50,
      healthy: false,
    ),
  ];
}