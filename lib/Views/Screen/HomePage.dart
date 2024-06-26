import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:ushop/helper/FbStoreHelper.dart';

import '../../Controller/ThemeController.dart';
import '../../Model/ProductModel.dart';
import 'DetilePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context).isDark;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('HomePage'),
          centerTitle: true,
          actions: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isDark ? Colors.white : Colors.black),
              ),
              child: IconButton(
                onPressed: () {
                  Provider.of<ThemeController>(context, listen: false)
                      .changeTheme();
                },
                icon: isDark
                    ? Icon(
                        Icons.light_mode_outlined,
                        size: 20,
                      )
                    : Icon(
                        Icons.light_mode,
                        size: 20,
                      ),
              ),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: FbStoreHelper.fbStoreHelper.fetchAllProducts(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              } else {
                QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> myData =
                    data?.docs ?? [];

                List<ProductModel> products =
                    myData.map((e) => ProductModel.fromMap(e.data())).toList();

                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      ProductModel product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(PageTransition(
                              child: DetailPage(
                                  product: product), //ProductModel(),
                              type: PageTransitionType.rightToLeft));
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(10),
                          height: 200,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.black : Color(0xfff9f9f9),
                            border: isDark
                                ? Border.all(width: 0)
                                : Border.all(
                                    color: Colors.grey.shade200,
                                    width: 2,
                                  ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              height: 170,
                              width: 128,
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
                                Text(
                                  "${product.price}",
                                  style: TextStyle(
                                      color: Color(0xffFD6932),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  height: size.height * 0.005,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${product.category}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Row(
                                        children: List.generate(
                                            product.rating.rate.toInt(),
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
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                      );
                    });
              }
            }));
  }
}
