import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 3,
          left: 4,
          right: 4,
          child: Card(
            child: TextFormField(
                textInputAction: TextInputAction.search,
                autofocus: true,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Buscar...',
                ),
                onFieldSubmitted: (text) {
                  Navigator.of(context).pop(text);
                }),
          ),
        )
      ],
    );
  }
}
