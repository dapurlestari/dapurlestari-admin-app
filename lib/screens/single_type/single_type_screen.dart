import 'package:admin/components/badges.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/server/content_type.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class SingleTypeScreen extends StatelessWidget {
  SingleTypeScreen({Key? key}) : super(key: key);

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      title: 'Single Type',
      showBackButton: false,
      body: _body
    ));
  }

  Widget get _body {
    if (mainController.isLoadingContentTypes.value) {
      return Center(child: Loadings.basic(),);
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 22),
      itemCount: mainController.singleTypes.length,
      itemBuilder: (_, i) {
        ContentType type = mainController.singleTypes[i];
        return InkWell(
          splashColor: Colors.yellow,
          onTap: type.open,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8
            ),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(type.schema.displayName,
                          style: Get.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 18
                          ),
                        ),
                        const SizedBox(height: 2,),
                        Text(type.uid,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: Get.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontFamily: ConstLib.monospaceFont,
                                color: Colors.grey.shade500,
                                fontSize: 14
                            )
                        ),
                      ],
                    )
                ),
                Row(
                  children: [
                    if (type.isComingSoon) Badges.comingSoon,
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(FeatherIcons.chevronRight, color: Colors.indigoAccent),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (_, i) => const Divider(
        color: Colors.white,
        indent: 20,
        endIndent: 20,
      ),
    );
  }
}
