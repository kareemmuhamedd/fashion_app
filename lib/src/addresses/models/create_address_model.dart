import 'dart:convert';

CreateAddressModel createAddressModelFromJson(String str) => CreateAddressModel.fromJson(json.decode(str));

String createAddressModelToJson(CreateAddressModel data) => json.encode(data.toJson());

class CreateAddressModel {
  final double lat;
  final double lng;
  final bool isDefault;
  final String address;
  final String phone;
  final String addressType;

  CreateAddressModel({
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.address,
    required this.phone,
    required this.addressType,
  });

  factory CreateAddressModel.fromJson(Map<String, dynamic> json) => CreateAddressModel(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    isDefault: json["isDefault"],
    address: json["address"],
    phone: json["phone"],
    addressType: json["addressType"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "isDefault": isDefault,
    "address": address,
    "phone": phone,
    "addressType": addressType,
  };
}
