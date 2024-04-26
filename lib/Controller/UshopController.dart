import 'package:flutter/material.dart';

import '../Model/CouponModal.dart';

class UshopController extends ChangeNotifier {
  bool isAplied = false;

  bool isdiscount = false;
  CouponModel couponModel = CouponModel.init();
  toggleApplied(
    bool val,
  ) {
    isAplied = val;
    notifyListeners();
  }

  appliedCoupon(CouponModel coupon) {
    couponModel = coupon;
    isdiscount = true;
    notifyListeners();
  }

  clearCouon() {
    isAplied = false;
    notifyListeners();
    couponModel = CouponModel.init();
  }
}
