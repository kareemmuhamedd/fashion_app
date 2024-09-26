import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/addresses/controllers/address_notifier.dart';
import 'package:fashion_app/src/addresses/hooks/fetch_address_list.dart';
import 'package:fashion_app/src/addresses/widgets/address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/utils/kcolors.dart';
import '../../../common/widgets/app_style.dart';
import '../../../common/widgets/reusable_text.dart';
import '../../../const/constants.dart';

class ShippingAddressScreen extends HookWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final results = fetchAddress();
    final addresses = results.address;
    final isLoading = results.isLoading;
    final refetch = results.refetch;
    if (isLoading) {
      return const Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: ListShimmer(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kAddresses,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: List.generate(
          addresses.length,
          (index) {
            final address = addresses[index];
            return AddressTile(
              address: address,
              isCheckout: false,
              onDelete: () {
                context
                    .read<AddressNotifier>()
                    .deleteAddress(address.id, refetch, context);
              },
              setDefault: () {
                context
                    .read<AddressNotifier>()
                    .setAsDefault(address.id, refetch, context);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.push('/addaddress');
        },
        child: Container(
          height: 80.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Kolors.kPrimaryLight,
            borderRadius: kRadiusTop,
          ),
          child: Center(
            child: ReusableText(
              text: 'Add Address',
              style: appStyle(
                16,
                Kolors.kWhite,
                FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
