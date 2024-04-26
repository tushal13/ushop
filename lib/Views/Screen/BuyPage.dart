import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ushop/Controller/ThemeController.dart';
import 'package:ushop/controller/UshopController.dart';

import '../../Model/CouponModal.dart';
import '../../Model/ProductModel.dart';
import '../../helper/FbStoreHelper.dart';

class BuyPage extends StatelessWidget {
  final ProductModel product;
  BuyPage({super.key, required this.product});

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController couponController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool couponApplied = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.category),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 170,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Color(0xffF8F8F8),
                      image: DecorationImage(
                          image: NetworkImage(
                            product.image,
                          ),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.5,
                      child: Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Consumer<UshopController>(builder: (context, pro, c) {
                      double discount = product.price -
                          ((product.price * (pro.couponModel.discount ?? 0)) /
                              100);
                      ;
                      return Row(
                        children: [
                          Text(
                            "${product.price}",
                            style: TextStyle(
                                color: couponApplied
                                    ? Provider.of<ThemeController>(context)
                                            .isDark
                                        ? Colors.white
                                        : Colors.black
                                    : Color(0xffFD6932),
                                decoration: couponApplied
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                fontWeight: FontWeight.w600,
                                fontSize: couponApplied ? 12 : 16),
                          ),
                          Visibility(
                            visible: couponApplied,
                            child: Row(
                              children: [
                                Text(
                                  '\t- ${pro.couponModel.discount}%',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${discount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Container(
                      width: size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${product.category}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: List.generate(product.rating.rate.toInt(),
                                (index) {
                              return Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      '${((product.rating.count - 20) / 20 * 100).toStringAsFixed(0)} reviews',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Container(
                      width: size.width * 0.5,
                      child: Text(
                        product.description,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
              StreamBuilder(
                  stream: FbStoreHelper.fbStoreHelper.fetchcoupen(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                    List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                        data?.docs ?? [];
                    List<CouponModel> coupens = myData
                        .map((e) => CouponModel.fromMap(e.data()))
                        .toList();
                    return Consumer<UshopController>(
                        builder: (context, pro, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: pro.isAplied,
                                  onChanged: (val) {
                                    pro.toggleApplied(val!);
                                  }),
                              Text('Apply coupon code',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                          Visibility(
                            visible: pro.isAplied,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                  key: formKey,
                                  child: TextFormField(
                                      controller: couponController,
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Enter coupon code';
                                        }
                                        // Check if the entered coupon code exists
                                        if (!coupens.any(
                                            (coupon) => coupon.code == val)) {
                                          return 'Invalid coupon code';
                                        }
                                        CouponModel coupon = coupens.firstWhere(
                                            (coupon) => coupon.code == val);
                                        if (coupon.count == 0) {
                                          return 'Coupon has been exhausted';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Enter coupon code',
                                      ))),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (!couponApplied &&
                                  formKey.currentState!.validate()) {
                                couponApplied = true;
                                Map<String, dynamic>? couponData =
                                    await FbStoreHelper.fbStoreHelper
                                        .fetchCoupo(couponController.text);
                                CouponModel coupon =
                                    CouponModel.fromMap(couponData!);

                                pro.appliedCoupon(coupon);
                                await FbStoreHelper.fbStoreHelper
                                    .decrementCoins(couponController.text);
                                await FbStoreHelper.fbStoreHelper
                                    .decrementProduct(product.id);
                                couponController.clear();
                              } else if (couponApplied) {
                                pro.clearCouon();
                                couponApplied = false;
                              }
                            },
                            child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: size.width,
                                height: size.height * 0.06,
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ],
                      );
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
