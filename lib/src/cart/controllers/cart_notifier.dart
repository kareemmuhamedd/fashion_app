import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/cart/models/cart_model.dart';
import 'package:fashion_app/src/entrypoint/controllers/bottom_tab_notifier.dart';
import 'package:fashion_app/src/products/controllers/color_sizes_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  Function? refetchCount;

  void setRefetchCount(Function f) {
    refetchCount = f;
  }

  int _qty = 0;

  int get qty => _qty;

  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectedCart;

  int? get selectedCart => _selectedCart;

  void setSelectedCounter(int id, int q) {
    _selectedCart = id;
    _qty = q;
    notifyListeners();
  }

  void clearSelected() {
    _selectedCart = null;
    // _selectedCartItems.clear();
    // _selectedCartItemsId.clear();
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/delete/?id=$id');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 204) {
        _selectedCartItems.removeWhere((item) => item.id == id);
        _selectedCartItemsId.remove(id);
        totalPrice = calculateTotalPrice(_selectedCartItems);

        refetch();
        refetchCount!();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse(
          '${Environment.appBaseUrl}/api/cart/update/?id=$id&count=$qty');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCart(String data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/cart/add/');
      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 201) {
        refetchCount!();
        ctx.read<ColorSizesNotifier>().setSizes('');
        ctx.read<ColorSizesNotifier>().setColor('');
        ctx.read<TabIndexNotifier>().setIndex(2);
        ctx.go('/home');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final List<int> _selectedCartItemsId = [];

  List<int> get selectedCartItemsId => _selectedCartItemsId;
  final List<CartModel> _selectedCartItems = [];

  List<CartModel> get selectedCartItems => _selectedCartItems;
  double totalPrice = 0.0;

  double calculateTotalPrice(List<CartModel> items) {
    double tp = 0.0;
    for (var item in items) {
      tp += item.product.price * item.quantity;
    }
    return tp;
  }

  void selectOrDeselect(int id, CartModel cartItem) {
    if (_selectedCartItemsId.contains(id)) {
      _selectedCartItemsId.remove(id);
      _selectedCartItems.removeWhere((item) => item.id == id);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    } else {
      _selectedCartItemsId.add(id);
      _selectedCartItems.add(cartItem);
      totalPrice = calculateTotalPrice(_selectedCartItems);
    }
    notifyListeners();
  }
}
