class ItemSizeModel {
  String? name;
  num? price;
  int? stock;
  ItemSizeModel({this.name, this.price, this.stock});
  bool get hasStock => stock != 0;

  ItemSizeModel.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }
  @override
  String toString() {
    return 'ItemSizeModel{name: $name, price: $price, stock: $stock}';
  }
}
