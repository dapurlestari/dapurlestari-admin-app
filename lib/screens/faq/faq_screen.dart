import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/faq/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'faq_controller.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({Key? key}) : super(key: key);

  final FaqController _controller = Get.put(FaqController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'FAQ',
        showBackButton: true,
        actions: [
          if (_controller.isRefresh.value) Loadings.basicPrimary,
          const SizedBox(width: 20,),
        ],
        body: SmartRefresher(
          controller: _controller.refresher.value,
          onRefresh: _controller.onRefresh,
          onLoading: _controller.onLoadMore,
          enablePullUp: !_controller.isRefresh.value,
          child: _body,
        )
    ));
  }

  Widget get _body {
    if (_controller.isRefresh.value) {
      return Container();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      itemCount: _controller.faqs.length,
      itemBuilder: (_, i) => item(_controller.faqs[i]),
      separatorBuilder: (_, i) => const Divider(height: 30, indent: 5, endIndent: 5),
    );
  }

  Widget item(Faq faq) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.indigoAccent)
      ),
      title: Text(faq.question, style: Get.textTheme.titleLarge?.copyWith(
        color: Colors.indigoAccent
      )),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 0.5),
        child: Text(faq.answer,
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Colors.blueGrey.shade500,
          )
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: const Color(0xFF4120A9)
          ),
        ),
        child: const Icon(
          FeatherIcons.edit2,
          size: 14,
          color: Color(0xFF4120A9),
        ),
      ),
    );
  }
}
