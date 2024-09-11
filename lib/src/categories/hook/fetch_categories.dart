import 'package:fashion_app/common/utils/environment.dart';
import 'package:fashion_app/src/categories/hook/results/categories_resutls.dart';
import 'package:fashion_app/src/categories/model/categories_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCategories fetchCategories() {
  final categories = useState<List<Categories>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse('${Environment.appBaseUrl}/api/products/categories');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        categories.value = categoriesFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchCategories(
    categories: categories.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
