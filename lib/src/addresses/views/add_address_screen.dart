import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/custom_button.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/addresses/controllers/address_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: true,
        title: ReusableText(
          text: AppText.kAddShipping,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<AddressNotifier>(
        builder: (context, addressNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            children: [
              SizedBox(
                height: 20.h,
              ),
              _buildtextfield(
                hintText: 'Phone Number',
                keyboard: TextInputType.phone,
                controller: _phoneController,
                onSubmitted: (pho) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              _buildtextfield(
                hintText: 'Address',
                keyboard: TextInputType.text,
                controller: _addressController,
                onSubmitted: (adr) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    addressNotifier.addressTypes.length,
                    (index) {
                      final addressType = addressNotifier.addressTypes[index];
                      return GestureDetector(
                        onTap: () {
                          addressNotifier.setAddressType(addressType);
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 20.w),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: addressNotifier.addressType == addressType
                                  ? Kolors.kPrimaryLight
                                  : Kolors.kWhite,
                              borderRadius: kRadiusAll,
                              border: Border.all(
                                color: Kolors.kPrimary,
                                width: 1,
                              )),
                          child: ReusableText(
                            text: addressType,
                            style: appStyle(
                              12,
                              addressNotifier.addressType == addressType
                                  ? Kolors.kWhite
                                  : Kolors.kPrimary,
                              FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReusableText(
                      text: 'Set this address as default',
                      style: appStyle(
                        14,
                        Kolors.kPrimary,
                        FontWeight.normal,
                      ),
                    ),
                    CupertinoSwitch(
                      value: addressNotifier.defaultToggle,
                      thumbColor: Kolors.kSecondaryLight,
                      activeTrackColor: Kolors.kPrimary,
                      onChanged: (val) {
                        addressNotifier.setDefaultToggle(val);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomButton(
                btnHieght: 35.h,
                radius: 9,
                text: 'S U B M I T',
                onTap: () {
                  if (_addressController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      addressNotifier.addressType != '') {
                    // todo :: add address
                  } else {
                    showErrorPopup(
                      context,
                      'Missing Address Fields',
                      'Error Adding Address',
                      false,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _buildtextfield extends StatelessWidget {
  const _buildtextfield({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.onSubmitted,
    this.keyboard,
    this.readOnly,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboard;
  final void Function(String)? onSubmitted;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: TextField(
          keyboardType: keyboard,
          readOnly: readOnly ?? false,
          decoration: InputDecoration(
              hintText: hintText,
              errorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kPrimary, width: 0.5),
              ),
              focusedErrorBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kRed, width: 0.5),
              ),
              disabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Kolors.kGray, width: 0.5),
              ),
              border: InputBorder.none),
          controller: controller,
          cursorHeight: 25,
          style: appStyle(12, Colors.black, FontWeight.normal),
          onSubmitted: onSubmitted),
    );
  }
}
