import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Menu {
  final int id;
  final String label;
  final IconData icon;
  bool active;

  Menu({
    this.id = 0,
    this.label = '',
    this.icon = FeatherIcons.home,
    this.active = false
  });

  static final menuList = [
    Menu(
      id: 1,
      label: 'Home',
      icon: FeatherIcons.home,
      active: true,
    ),
    Menu(
      id: 2,
      label: 'Collection',
      icon: FeatherIcons.package,
      active: false,
    ),
    Menu(
      id: 3,
      label: 'Single',
      icon: FeatherIcons.layout,
      active: false,
    ),
    Menu(
      id: 4,
      label: 'Settings',
      icon: FeatherIcons.settings,
      active: false,
    ),
  ];
}