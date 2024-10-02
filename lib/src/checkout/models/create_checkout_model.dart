import 'dart:convert';

CreateCheckoutModel createCheckoutModelFromJson(String str) => CreateCheckoutModel.fromJson(json.decode(str));

String createCheckoutModelToJson(CreateCheckoutModel data) => json.encode(data.toJson());

class CreateCheckoutModel {
  final String accesstoken;
  final String fcm;
  final double totalAmount;
  final List<CartItem> cartItems;
  final int address;

  CreateCheckoutModel({
    required this.accesstoken,
    required this.fcm,
    required this.totalAmount,
    required this.address,
    required this.cartItems,
  });

  factory CreateCheckoutModel.fromJson(Map<String, dynamic> json) => CreateCheckoutModel(
    accesstoken: json["accesstoken"],
    fcm: json["fcm"],
    totalAmount: json["totalAmount"]?.toDouble(),
    address: json["address"],
    cartItems: List<CartItem>.from(json["cartItems"].map((x) => CartItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "accesstoken": accesstoken,
    "fcm": fcm,
    "totalAmount": totalAmount,
    "address": address,
    "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
  };
}

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  final String name;
  final String size;
  final String color;
  final int id;
  final double price;
  final int cartQuantity;

  CartItem({
    required this.name,
    required this.size,
    required this.color,
    required this.id,
    required this.price,
    required this.cartQuantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    name: json["name"],
    size: json["size"],
    color: json["color"],
    id: json["id"],
    price: json["price"]?.toDouble(),
    cartQuantity: json["cartQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "size": size,
    "color": color,
    "id": id,
    "price": price,
    "cartQuantity": cartQuantity,
  };
}
