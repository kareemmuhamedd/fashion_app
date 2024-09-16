import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/cart/models/create_cart_model.dart';
import 'package:fashion_app/src/products/controllers/color_sizes_notifier.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:fashion_app/src/products/widgets/color_selection_widget.dart';
import 'package:fashion_app/src/products/widgets/expandable_text.dart';
import 'package:fashion_app/src/products/widgets/product_bottom_bar.dart';
import 'package:fashion_app/src/products/widgets/product_sizes_widget.dart';
import 'package:fashion_app/src/products/widgets/similar_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import '../../../common/services/storage.dart';
import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/login_bottom_sheet.dart';
import '../../../const/constants.dart';
import '../../wishlist/controllers/wishlist_notifier.dart';

class ProductScreen extends StatelessWidget {
  final String productId;

  const ProductScreen({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 320.h,
                collapsedHeight: 65.h,
                floating: false,
                pinned: true,
                leading: const AppBackButton(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Consumer<WishlistNotifier>(
                      builder: (context, wishlistNotifier, child) {
                        return GestureDetector(
                          onTap: () {
                            if (accessToken == null) {
                              loginBottomSheet(context);
                            } else {
                              context
                                  .read<WishlistNotifier>()
                                  .addRemoveWishlist(
                                      productNotifier.product!.id, () {});
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Kolors.kSecondaryLight,
                            child: Icon(
                              AntDesign.heart,
                              color: wishlistNotifier.wishlist
                                      .contains(productNotifier.product!.id)
                                  ? Kolors.kRed
                                  : Kolors.kGray,
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      indicatorColor: Kolors.kPrimaryLight,
                      autoPlayInterval: 15000,
                      isLoop: productNotifier.product!.imageUrls.length > 1
                          ? true
                          : false,
                      children: List.generate(
                        productNotifier.product!.imageUrls.length,
                        (image) {
                          return CachedNetworkImage(
                            placeholder: placeholder,
                            errorWidget: errorWidget,
                            height: 415.h,
                            imageUrl: productNotifier.product!.imageUrls[image],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text:
                            productNotifier.product!.clothesType.toUpperCase(),
                        style: appStyle(
                          13,
                          Kolors.kGray,
                          FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            AntDesign.star,
                            color: Kolors.kGold,
                            size: 14,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          ReusableText(
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style: appStyle(
                              13,
                              Kolors.kGray,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(
                      16,
                      Kolors.kDark,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: ExpandableText(
                    text: productNotifier.product!.description,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(
                    thickness: 0.5.h,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ReusableText(
                    text: 'Select Sizes',
                    style: appStyle(
                      14,
                      Kolors.kDark,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ProductSizesWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ReusableText(
                    text: 'Select Color',
                    style: appStyle(
                      14,
                      Kolors.kDark,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ColorSelectionWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ReusableText(
                    text: 'Similar Products',
                    style: appStyle(
                      14,
                      Kolors.kDark,
                      FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SimilarProduct(),
              ),
            ],
          ),
          bottomNavigationBar: ProductBottomBar(
              onPressed: () {
                if (accessToken == null) {
                  loginBottomSheet(context);
                } else {
                  if (context.read<ColorSizesNotifier>().color == '' ||
                      context.read<ColorSizesNotifier>().sizes == '') {
                    showErrorPopup(
                      context,
                      AppText.kCartErrorText,
                      'Error Adding to Cart',
                      true,
                    );
                  } else {
                    CreateCartModel data = CreateCartModel(
                     product: context.read<ProductNotifier>().product!.id,
                      quantity: 1,
                      size: context.read<ColorSizesNotifier>().sizes,
                      color: context.read<ColorSizesNotifier>().color,
                    );
                    String cartData = createCartModelToJson(data);
                    context.read<CartNotifier>().addToCart(cartData, context);
                  }
                }
              },
              price: productNotifier.product!.price.toStringAsFixed(1)),
        );
      },
    );
  }
}
