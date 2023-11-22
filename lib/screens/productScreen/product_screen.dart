import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_model.dart';
import 'package:loja_virtual/screens/produtcs/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final ProductModel productModel;
  const ProductScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Provider<ProductModel>(
      create: (_) => productModel,
      lazy: false,
      builder: (context, child) {
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
                      child: Text(
                        'A partir de ',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                    Text(
                      'R\$ 19.99',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Descrição',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      productModel.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'Tamanhos',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: productModel.sizes.map((s) {
                        return SizeWidget(size: s);
                      }).toList(),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
