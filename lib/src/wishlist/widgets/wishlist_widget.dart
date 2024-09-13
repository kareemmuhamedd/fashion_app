import 'package:fashion_app/common/widgets/empty_screen_widget.dart';
import 'package:fashion_app/src/wishlist/hooks/fetch_wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../../../common/services/storage.dart';
import '../../../common/widgets/login_bottom_sheet.dart';
import '../../../common/widgets/shimmers/list_shimmer.dart';
import '../../products/widgets/staggered_tile_widget.dart';
import '../controllers/wishlist_notifier.dart';
class WishlistWidget extends HookWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final results = fetchWishlist();
    final products = results.products;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    final error = results.error;

    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }
    return products.isEmpty
        ? const EmptyScreenWidget()
        : Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.h),
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
                    context
                        .read<WishlistNotifier>()
                        .addRemoveWishlist(product.id,refetch );
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
