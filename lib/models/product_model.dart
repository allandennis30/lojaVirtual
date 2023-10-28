import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  late String id;
  late String name;
  late String description;
  late List<String> images;

  ProductModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
  }
}
