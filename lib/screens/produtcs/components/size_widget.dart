import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size_model.dart';

class SizeWidget extends StatelessWidget {
  final ItemSizeModel size;
  const SizeWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              size.name!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'R\$ ${size.price?.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.black45,
              ),
            ),
          )
        ],
      ),
    );
  }
}
