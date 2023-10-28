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
          title: const Text('Produtos'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final search = await showDialog<String>(
                    context: context, builder: (_) => const SearchDialog());
                if (search != null) {
                  context.read<ProductManager>().search = search;
                }
              },
              icon: const Icon(Icons.search),
            )
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
