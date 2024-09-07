import 'package:fashion_app/src/home/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: CustomAppBar(),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        children: [
          SizedBox(height: 20.h,),
          const HomeSlider(),
        ],
      ),
    );
  }
}
