import 'package:fashion_app/common/utils/environment.dart';
import 'package:flutter/material.dart';

import '../../products/models/products_model.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Products> _results = [];

  List<Products> get results => _results;

  void setResults(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
  }

  String _searchKey = '';

  String get searchKey => _searchKey;

  void setSearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  String? _error;

  String get error => _error ?? "";

  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  void searchFunction(String searchKey) async {
    setLoading(true);
    setSearchKey(searchKey);
    Uri url = Uri.parse(
        '${Environment.appBaseUrl}/api/products/search/?q=$searchKey');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = productsFromJson(response.body);
        setResults(data);
        setLoading(false);
      }
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
}
