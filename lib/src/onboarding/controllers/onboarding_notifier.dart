import 'package:flutter/cupertino.dart';

class OnboardingNotifier with ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  set setSelectedPage(int pageIndex) {
    _selectedPage = pageIndex;
    notifyListeners();
  }
}
