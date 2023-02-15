import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/server/content_type.dart';
import 'package:admin/screens/main_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';

class CollectionScreen extends StatelessWidget {
  CollectionScreen({Key? key}) : super(key: key);

  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      title: 'Collection',
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
      itemCount: mainController.collectionTypes.length,
      itemBuilder: (_, i) {
        ContentType type = mainController.collectionTypes[i];
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
                    if (type.isComingSoon) Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: Text('Coming Soon', style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade100,
                        fontSize: 8.7
                      )),
                    ),
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
