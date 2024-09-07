import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/tab_widget.dart';
import 'package:fashion_app/src/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTabs extends StatelessWidget {
  final TabController _tabController;

  const HomeTabs({super.key, required TabController tabController})
      : _tabController = tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22.h,
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Kolors.kPrimary,
          borderRadius: BorderRadius.circular(25),
        ),
        labelPadding: EdgeInsets.zero,
        labelColor: Kolors.kWhite,
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        labelStyle: appStyle(11, Kolors.kPrimary, FontWeight.w600),
        unselectedLabelStyle: appStyle(11, Kolors.kGray, FontWeight.normal),
        tabs: List.generate(
          homeTabs.length,
          (index) {
            return Tab(
              child: TabWidget(text: homeTabs[index]),
            );
          },
        ),
      ),
    );
  }
}
