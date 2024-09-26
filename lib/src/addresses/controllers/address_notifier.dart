import 'package:fashion_app/common/models/api_error_model.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/src/addresses/models/address_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../common/services/storage.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  Function refetchA = () {};

  void setRefetch(Function f) {
    refetchA = f;
  }

  AddressModel? address;

  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  List<String> addressTypes = ["Home", "School", "Office"];
  String _addressType = '';

  String get addressType => _addressType;

  void setAddressType(String type) {
    _addressType = type;
    notifyListeners();
  }

  void clearAddressType() {
    _addressType = '';
  }

  bool _defaultToggle = false;

  bool get defaultToggle => _defaultToggle;

  void setDefaultToggle(bool value) {
    _defaultToggle = value;
    notifyListeners();
  }

  void clearDefaultToggle() {
    _defaultToggle = false;
  }

  void setAsDefault(int id, Function refetch, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/default/?id=$id');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(ctx, data.message, 'Error changing address', true);
        print(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _defaultToggle = true;
    notifyListeners();
  }

  void deleteAddress(int id, Function refetch, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url =
          Uri.parse('${Environment.appBaseUrl}/api/address/delete/?id=$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 204) {
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(ctx, data.message, 'Error deleting address', true);
        print(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    _defaultToggle = true;
    notifyListeners();
  }

  void addAddress(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/address/add/');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        refetchA();
        ctx.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(ctx, e.toString(), 'Error adding address', true);
    }
    _defaultToggle = true;
    notifyListeners();
  }
}
