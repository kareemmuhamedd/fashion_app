import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/categories/controllers/category_notifier.dart';
import 'package:fashion_app/src/products/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../common/services/storage.dart';
import '../../../common/widgets/login_bottom_sheet.dart';
import '../../categories/hook/fetch_product_by_category.dart';

class ProductByCategory extends HookWidget {
  const ProductByCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchProductsByCategories(context.read<CategoryNotifier>().id);
    final products = results.products;
    final isLoading = results.isLoading;
    final error = results.error;
    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.h),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          products.length,
          (index) {
            final double mainAxisCellCount = (index % 2 == 0) ? 2.17 : 2.4;
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
