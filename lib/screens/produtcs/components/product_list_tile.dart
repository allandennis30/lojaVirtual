import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product_model.dart';

class ProductListTile extends StatelessWidget {
  final ProductModel product;

  ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            height: 100,
            padding: const EdgeInsets.all(8),
            child: Row(children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                      )),
                  const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text('A partir de ',
                          style: TextStyle(color: Colors.grey, fontSize: 12))),
                  Text('R\$ 19.99',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 15)),
                ],
              ))
            ])));
  }
}
