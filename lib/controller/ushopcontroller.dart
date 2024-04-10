import 'package:flutter/material.dart';

class UshopController extends ChangeNotifier {
  bool isAplied = false;

  toggleApplied(
    bool val,
  ) {
    isAplied = val;
    notifyListeners();
  }
}
