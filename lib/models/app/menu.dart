import 'package:admin/screens/media_library/media_library_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class Menu {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  bool active;
  final GestureTapCallback? onTap;

  Menu({
    this.id = 0,
    this.title = '',
    this.subtitle = '',
    this.icon = FeatherIcons.home,
    this.active = false,
    this.onTap
  });

  static final navBar = [
    Menu(
      id: 1,
      title: 'Home',
      icon: FeatherIcons.home,
      active: true,
    ),
    Menu(
      id: 2,
      title: 'Collection',
      icon: FeatherIcons.package,
      active: false,
    ),
    Menu(
      id: 3,
      title: 'Single',
      icon: FeatherIcons.layout,
      active: false,
    ),
    Menu(
      id: 4,
      title: 'Settings',
      icon: FeatherIcons.settings,
      active: false,
    ),
  ];

  static final homeMenu = [
    Menu(
      title: 'Media Library',
      subtitle: 'Explore and manage uploaded files and media',
      icon: FeatherIcons.image,
      onTap: () => Get.to(() => MediaLibraryScreen())
    ),
    Menu(
      title: 'Email',
      subtitle: 'Test drive sending email to specific users',
      icon: FeatherIcons.mail,
    ),
  ];
}