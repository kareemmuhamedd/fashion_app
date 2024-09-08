import 'package:fashion_app/common/utils/app_routes.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/custom_button.dart';
import 'package:fashion_app/common/widgets/help_bottom_sheet.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/profile/widget/profile_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              const CircleAvatar(
                radius: 35,
                backgroundColor: Kolors.kOffWhite,
                backgroundImage: NetworkImage(AppText.kProfilePic),
              ),
              SizedBox(
                height: 15.h,
              ),
              ReusableText(
                text: 'karmoh@gmail.com',
                style: appStyle(
                  11,
                  Kolors.kGray,
                  FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: Kolors.kOffWhite,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ReusableText(
                  text: 'Kareem Muhamed',
                  style: appStyle(
                    14,
                    Kolors.kDark,
                    FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            color: Kolors.kOffWhite,
            child: Column(
              children: [
                ProfileTileWidget(
                  title: 'My Orders',
                  leading: Octicons.checklist,
                  onTap: () {
                    context.push('/orders');
                  },
                ),
                ProfileTileWidget(
                  title: 'Shipping Address',
                  leading: MaterialIcons.location_pin,
                  onTap: () {
                    context.push('/addresses');
                  },
                ),
                ProfileTileWidget(
                  title: 'Privacy Policy',
                  leading: MaterialIcons.policy,
                  onTap: () {
                    context.push('/policy');
                  },
                ),
                ProfileTileWidget(
                  title: 'Help Center',
                  leading: AntDesign.customerservice,
                  onTap: () => showHelpCenterBottomSheet(context),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomButton(
              text: 'Logout'.toUpperCase(),
              btnColor: Kolors.kRed,
              btnHieght: 35,
              btnWidth: ScreenUtil().screenWidth,
            ),
          )
        ],
      ),
    );
  }
}
