import 'package:flutter/widgets.dart';

class HistoryProvider with ChangeNotifier{
  int _seletedIndex = 1;
  int get selectedIndex => _seletedIndex;

  void selectIndex(int index){
    _seletedIndex = index;
    notifyListeners();
  }
}