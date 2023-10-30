import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/custom_drawer/custom_drawer.dart';
import 'package:loja_virtual/models/product_manager.dart';
import 'package:loja_virtual/screens/produtcs/components/product_list_tile.dart';
import 'package:loja_virtual/screens/produtcs/components/search_dialog.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Consumer<ProductManager>(builder: (_, productManager, __) {
            if (productManager.search.isEmpty) {
              print(productManager.search);
              return const Text('Produtos');
            } else {
              return LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  onTap: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(
                        initalText: productManager.search,
                      ),
                    );
                    if (search != null) {
                      context.read<ProductManager>().search = search;
                    }
                  },
                  child: Container(
                    width: constraints.biggest.width,
                    child: Consumer<ProductManager>(
                      builder: (_, productManager, __) => Text(
                        productManager.search,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              });
            }
          }),
          centerTitle: true,
          actions: <Widget>[
            Consumer<ProductManager>(builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  onPressed: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) =>
                          SearchDialog(initalText: productManager.search),
                    );
                    if (search != null) {
                      context.read<ProductManager>().search = search;
                    }
                  },
                  icon: const Icon(Icons.search),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            })
          ],
        ),
        body: Consumer<ProductManager>(
          builder: (_, productManager, __) {
            final filtredProducts = productManager.filteredProducts;
            return ListView.builder(
              padding: const EdgeInsets.all(4),
              itemCount: filtredProducts.length,
              itemBuilder: (_, index) {
                return ProductListTile(product: filtredProducts[index]);
              },
            );
          },
        ));
  }
}
