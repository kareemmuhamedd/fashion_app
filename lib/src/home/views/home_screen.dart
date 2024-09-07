import 'package:fashion_app/src/home/controllers/home_tab_notifier.dart';
import 'package:fashion_app/src/home/widgets/custom_app_bar.dart';
import 'package:fashion_app/src/home/widgets/home_categories_list.dart';
import 'package:fashion_app/src/home/widgets/home_header.dart';
import 'package:fashion_app/src/home/widgets/home_tabs.dart';
import 'package:fashion_app/src/products/widgets/explore_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/home_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: homeTabs.length, vsync: this);
    _tabController.addListener(_handleSelection);
    super.initState();
  }

  void _handleSelection() {
    final controller = Provider.of<HomeTabNotifier>(context, listen: false);
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      controller.setIndex(homeTabs[_currentTabIndex]);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: CustomAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(
            height: 20.h,
          ),
          const HomeSlider(),
          SizedBox(
            height: 15.h,
          ),
          const HomeHeader(),
          SizedBox(
            height: 10.h,
          ),
          const HomeCategoriesList(),
          SizedBox(
            height: 15.h,
          ),
          HomeTabs(tabController: _tabController),
          SizedBox(
            height: 15.h,
          ),
          const ExploreProducts(),
          SizedBox(
            height: 100.h,
          ),
        ],
      ),
    );
  }
}

List<String> homeTabs = [
  'All',
  'Popular',
  'Unisex',
  'Men',
  'Women',
  'Kids',
];
