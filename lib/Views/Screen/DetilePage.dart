import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ushop/views/screen/BuyPage.dart';

import '../../Model/ProductModel.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(product.category.toUpperCase(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Container(
                alignment: Alignment.center,
                height: size.height * 0.45,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(product.image),
                ))),
          ),
          const Divider(
            color: Colors.black,
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Price: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextSpan(
                            text: '${product.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    product.rating.count > 0
                        ? Text(
                            'In Stock',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.green),
                          )
                        : Text(
                            'Out of Stock',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.red),
                          ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Rating: ',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    Expanded(
                      child: Container(
                        height: size.height * 0.02,
                        alignment: Alignment.center,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.rating.rate.toInt(),
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  child: Text(product.description,
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageTransition(
                  child: BuyPage(product: product), //ProductModel(),
                  type: PageTransitionType.rightToLeft));
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
        ]),
      ),
    );
  }
}
