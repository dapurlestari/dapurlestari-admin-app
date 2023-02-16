import 'package:admin/components/custom_scaffold.dart';
import 'package:admin/components/loadings.dart';
import 'package:admin/models/product/product.dart';
import 'package:admin/screens/product/product_controller.dart';
import 'package:admin/screens/product/product_form.dart';
import 'package:admin/services/text_formatter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  final ProductController _controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
        title: 'Products',
        actions: [
          if (_controller.isRefresh.value) Loadings.basicPrimary,
          const SizedBox(width: 20,),
          IconButton(
            icon: const Icon(LineIcons.plus,
                color: Colors.indigoAccent
            ),
            onPressed: () => Get.to(() => ProductForm(product: Product.dummy(),)),
          )
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
      itemCount: _controller.products.length,
      itemBuilder: (_, i) => item(_controller.products[i]),
      separatorBuilder: (_, i) => const SizedBox(height: 20),
    );
  }

  Widget item(Product product) {
    return InkWell(
      child: AspectRatio(
        aspectRatio: 6/2,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.indigoAccent),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    placeholder: (context, url) => Loadings.basicPrimary,
                    errorWidget: (context, url, error) => const Text('Image Error'),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('#${product.id}', style: Get.textTheme.titleLarge?.copyWith(
                      color: Colors.indigo.shade600,
                      fontSize: 16
                  )),
                  Text(product.name, style: Get.textTheme.titleLarge?.copyWith(
                      color: Colors.indigoAccent
                  ), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(product.pirtCode,
                      style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                      )
                  ),
                  const SizedBox(height: 10),
                  Text('Rp. ${TextFormatter.formatPrice(product.price)}',
                      style: Get.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w300
                      )
                  ),

                ],
              )),
            ],
          ),
        ),
      ),
      onTap: () => Get.to(() => ProductForm(product: product)),
    );
  }
}
