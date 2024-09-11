import 'package:fashion_app/common/widgets/empty_widget.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:fashion_app/src/products/hooks/fetch_similar_product.dart';
import 'package:fashion_app/src/products/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../../common/services/storage.dart';
import '../../../const/constants.dart';

class SimilarProduct extends HookWidget {
  const SimilarProduct({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results =
        fetchSimilarProducts(context.read<ProductNotifier>().product!.category);

    /// i think it should be product id
    final products = results.products;
    final isLoading = results.isLoading;
    final error = results.error;
    if(isLoading){
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return products.isEmpty
        ? const EmptyWidget()
        : Padding(
            padding: EdgeInsets.all(8.h),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(
                products.length,
                (index) {
                  final double mainAxisCellCount =
                      (index % 2 == 0) ? 2.17 : 2.4;
                  final product = products[index];
                  return StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: mainAxisCellCount,
                    child: StaggeredTileWidget(
                      onTap: () {
                        if (accessToken == null) {
                          loginBottomSheet(context);
                        } else {
                          // todo handle wishlist functionality
                        }
                      },
                      index: index,
                      product: product,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
