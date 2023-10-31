import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_model.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(productModel.name),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: AnotherCarousel(
                images: productModel.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: Theme.of(context).primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productModel.name,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('A partir de ',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ),
                    Text('R\$ 19.99',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Descrição',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        )),
                    Text(productModel.description,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                  ],
                ))
          ],
        ));
  }
}
