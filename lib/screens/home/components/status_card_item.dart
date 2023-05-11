import 'package:admin/models/server/access_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusCardItem extends StatelessWidget {
  final bool checking;
  final bool healthy;
  final AccessStatus accessStatus;
  const StatusCardItem({Key? key,
    required this.accessStatus,
    required this.checking,
    required this.healthy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade50
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Badge(
                backgroundColor: checking
                    ? Colors.orangeAccent
                    : healthy ? Colors.greenAccent : Colors.red
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(accessStatus.icon),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(accessStatus.label, style: Get.textTheme.titleMedium?.copyWith(
                      color: Colors.indigoAccent
                  )),
                  Text('Tap to refresh', style: Get.textTheme.bodySmall),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
