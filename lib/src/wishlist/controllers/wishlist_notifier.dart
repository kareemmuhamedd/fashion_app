import 'dart:convert';

import 'package:fashion_app/common/services/storage.dart';
import 'package:flutter/cupertino.dart';

import '../../../common/utils/environment.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;

  void setError(String e) {
    error = e;
    notifyListeners();
  }

  void addRemoveWishlist(int id, Function refetch) async {
    final accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/wishlist/toggle/?id=$id');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 201) {
        // SET THE ID TO A LIST IN OUR LOCAL STORAGE
        setToList(id);
        refetch();
      } else if (response.statusCode == 204) {
        // REMOVE THE ID FROM THE LIST IN OUR LOCAL STORAGE
        setToList(id);
        refetch();
      }
    } catch (e) {
      print(e);
      error = e.toString();
    }
    notifyListeners();
  }

  List _wishlist = [];

  List get wishlist => _wishlist;

  void setWishlist(List val) {
    _wishlist.clear();
    _wishlist = val;
    notifyListeners();
  }

  void setToList(int val) {
    String? accessToken = Storage().getString('accessToken');
    String? wishlist = Storage().getString('${accessToken}wishlist');
    if (wishlist == null) {
      List wishlist = [];
      wishlist.add(val);
      setWishlist(wishlist);
      Storage().setString('${accessToken}wishlist', jsonEncode(wishlist));
    } else {
      List w = jsonDecode(wishlist);
      if (w.contains(val)) {
        w.removeWhere((e) => e == val);
        setWishlist(w);
        Storage().setString('${accessToken}wishlist', jsonEncode(w));
      } else if (!w.contains(val)) {
        w.add(val);
        setWishlist(w);
        Storage().setString('${accessToken}wishlist', jsonEncode(w));
      }
    }
  }
}
