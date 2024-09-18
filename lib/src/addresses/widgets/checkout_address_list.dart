import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/addresses/hooks/fetch_address_list.dart';
import 'package:fashion_app/src/addresses/widgets/select_address_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutAddressList extends HookWidget {
  const CheckoutAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final result = fetchAddress();
    final isLoading = result.isLoading;
    final addresses = result.address;
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: const ListShimmer(),
      );
    }
    return ListView(
      children: List.generate(
        addresses.length,
        (index) {
          return SelectAddressTile(address: addresses[index]);
        },
      ),
    );
  }
}
