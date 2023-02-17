import 'package:admin/components/buttons/buttons.dart';
import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/forms/custom_text_field.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/screens/components/galleryfuls_form.dart';
import 'package:admin/screens/components/seo_form.dart';
import 'package:admin/screens/single_type/home/home_page_controller.dart';
import 'package:admin/services/constant_lib.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageScreen extends StatelessWidget {
  HomePageScreen({Key? key}) : super(key: key);

  final _controller = Get.put(HomePageController());
  final galleryfulsController = Get.put(GalleryfulsController(), tag: '${ConstLib.homePage}.galleryfuls');

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Settings',
        actions: [
          if (_controller.isRefresh.value) Loadings.basicPrimary,
          const SizedBox(width: 15,)
        ],
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Scrollbar(
                  radius: const Radius.circular(20),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 22, 15, 150),
                    children: [
                      CustomField.fieldGroup(
                          label: 'General',
                          content: Column(
                            children: [
                              CustomField.text(
                                controller: _controller.descriptionField.value,
                                hint: 'Add description to for this page',
                                label: 'Description',
                                minLines: 3,
                                maxLines: 5
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 40),
                      GalleryfulsForm(
                        galleryfuls: _controller.slideshows,
                        tag: ConstLib.homePage,
                      ),
                      const SizedBox(height: 40),
                      SeoForm(
                        seo: _controller.homePage.value.seo,
                        tag: ConstLib.homePage,
                      )
                    ],
                  )
              ),
            ),
            Buttons.floatingBottomButton(
                isLoading: _controller.saving.value,
                onPressed: _controller.save
            )
          ],
        )
    ));
  }
}
