import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../Model/ProductModel.dart';

class FbStoreHelper {
  FbStoreHelper._();

  static final FbStoreHelper fbStoreHelper = FbStoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String usersCollection = 'Users';
  String allusersCollection = 'AllUsers';

  insertproduct() async {
    String apiUrl = 'https://fakestoreapi.com/products';
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      List data = responseData;
      List<ProductModel> products =
          data.map((e) => ProductModel.fromMap(e)).toList();

      products.forEach((e) async {
        await firestore
            .collection('products')
            .doc(e.id.toString())
            .set(e.toJson());
      });
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProducts() {
    return firestore.collection('products').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchcoupen() {
    return firestore.collection('couponcode').snapshots();
  }

  Future<Map<String, dynamic>?> fetchCoupo(String code) async {
    DocumentSnapshot<Map<String, dynamic>> couponSnapshot =
        await firestore.collection('couponcode').doc(code).get();
    return couponSnapshot.data();
  }

  decrementCoins(String code) async {
    await firestore.collection('couponcode').doc(code).update({
      'count': FieldValue.increment(-1),
    });
  }

  decrementProduct(int id) async {
    await firestore.collection('products').doc(id.toString()).update({
      'rating.count': FieldValue.increment(-1),
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProducts(int id) {
    return firestore.collection('products').doc(id.toString()).snapshots();
  }
}
