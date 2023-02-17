import 'package:admin/components/buttons/menu_button.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/models/app/menu.dart';
import 'package:admin/models/server/access_status.dart';
import 'package:admin/screens/home/home_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:admin/services/date_times.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/status_card_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        useAppBar: false,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                  color: const Color(0xFFA1A9FE),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.shade200,
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    )
                  ]
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/logo.png', height: 80,),
                  const SizedBox(height: 40),
                  Text('Good ${DateTimes.hourName}, Admin!', style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontFamily: ConstLib.secondaryFont,
                      letterSpacing: 0.5,
                      fontSize: 28,
                      color: Colors.white
                  )),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() => GridView(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3/2
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        InkWell(
                          onTap: homeController.checkServerStatus,
                          child: StatusCardItem(
                            accessStatus: AccessStatus.statusList[0],
                            checking: homeController.serverChecking.value,
                            healthy: homeController.serverStatus.value,
                          ),
                        ),
                        InkWell(
                          onTap: homeController.checkAPIStatus,
                          child: StatusCardItem(
                            accessStatus: AccessStatus.statusList[1],
                            checking: homeController.apiChecking.value,
                            healthy: homeController.apiStatus.value,
                          ),
                        ),
                        InkWell(
                          onTap: homeController.checkSiteStatus,
                          child: StatusCardItem(
                            accessStatus: AccessStatus.statusList[2],
                            checking: homeController.siteChecking.value,
                            healthy: homeController.siteStatus.value,
                          ),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Menu.homeMenu.length,
              itemBuilder: (_, i) => MenuButton(menu: Menu.homeMenu[i]),
              separatorBuilder: (_, i) => Divider(indent: 20, endIndent: 20, color: Colors.grey.shade200),
            )
          ],
        )
    );
  }
}
