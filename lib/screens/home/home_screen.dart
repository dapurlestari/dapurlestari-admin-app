import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/server/access_status.dart';
import 'package:admin/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      useAppBar: false,
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: homeController.accessStatuses.map((accessStatus)
                => statusCard(accessStatus)).toList(),
            ),
          )
        ],
      )
    ));
  }

  Widget statusCard(AccessStatus accessStatus) {
    return Container(
      decoration: BoxDecoration(
          color: accessStatus.bgColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 3),
            )
          ]
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Text(accessStatus.label, style: Get.textTheme.titleSmall),
          SizedBox(width: 10,),
          Icon(
            accessStatus.healthy ? FeatherIcons.cloud : FeatherIcons.cloudOff,
            size: 16,
            color: accessStatus.healthy ? Colors.cyan : Colors.red,
          )
        ],
      ),
    );
  }
}
