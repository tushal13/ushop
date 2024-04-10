class CouponModel {
  int count;
  int discount;
  String code;

  CouponModel({
    required this.count,
    required this.discount,
    required this.code,
  });

  factory CouponModel.fromMap(Map coupon) {
    return CouponModel(
      count: coupon['count'],
      discount: coupon['discount'],
      code: coupon['code'],
    );
  }
}
