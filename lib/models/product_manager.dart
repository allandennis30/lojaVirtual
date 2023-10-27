import 'package:cloud_firestore/cloud_firestore.dart';

class ProducManager {
  ProducManager() {
    _loadAllProducts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _loadAllProducts() async {
    final QuerySnapshot snapProducts =
        await firestore.collection('products').get();
    {}
  }
}
