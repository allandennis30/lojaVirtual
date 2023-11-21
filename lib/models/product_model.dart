import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/item_size_model.dart';

class ProductModel {
  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<ItemSizeModel> sizes;

  ProductModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    sizes = (document['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSizeModel.fromMap(s as Map<String, dynamic>))
        .toList();

    print('$sizes tentei obter os tamanhos');
  }
}
