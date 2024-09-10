import 'dart:convert';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/src/auth/models/auth_token_model.dart';
import 'package:fashion_app/src/auth/models/profile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../../entrypoint/controllers/bottom_tab_notifier.dart';
import '../../../common/services/storage.dart';
import 'package:provider/provider.dart';

class AuthNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  bool _isRLoading = false;

  bool get isRLoading => _isLoading;

  void setRLoading() {
    _isRLoading = !_isRLoading;
    notifyListeners();
  }

  void loginFunc(String data, BuildContext ctx) async {
    setLoading(true);
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/token/login/');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        String accessToken = accessTokenModelFromJson(response.body).authToken;
        getUser(accessToken, ctx);
        setLoading(false);
      } else if (response.statusCode == 400) {
        setLoading(false);
        showErrorPopup(ctx, 'Login Failure', null, null);
      }
    } catch (e) {
      setLoading(false);
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void registrationFunc(String data, BuildContext ctx) async {
    setRLoading();
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data,
      );
      if (response.statusCode == 201) {
        setRLoading();
        ctx.pop();
      } else if (response.statusCode == 400) {
        setRLoading();
        var data = jsonDecode(response.body);
        showErrorPopup(ctx, data['password'][0], null, null);
      }
    } catch (e) {
      setRLoading();
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  void getUser(String accessToken, BuildContext ctx) async {
    try {
      var url = Uri.parse('${Environment.appBaseUrl}/auth/users/me/');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        Storage().setString('accessToken', accessToken);
        Storage().setString(accessToken, response.body);
        ctx.read<TabIndexNotifier>().setIndex(0);
        ctx.go('/home');
      }
    } catch (e) {
      setLoading(false);
      showErrorPopup(ctx, AppText.kErrorLogin, null, null);
    }
  }

  ProfileModel? getUserData() {
    String? accessToken = Storage().getString('accessToken');
    if (accessToken != null) {
      var data = Storage().getString(accessToken);
      if (data != null) {
        return profileModelFromJson(data);
      }
    }
    return null;
  }
}
