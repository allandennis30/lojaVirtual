import 'package:flutter/material.dart';
import 'package:loja_virtual/commom/custom_drawer/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerTile(title: 'Inicio', iconData: Icons.home, page: 0),
          DrawerTile(title: 'Produtos', iconData: Icons.list, page: 1),
          DrawerTile(
              title: 'Meus Pedidos',
              iconData: Icons.playlist_add_check,
              page: 2),
          DrawerTile(title: 'Lojas', iconData: Icons.location_on, page: 3),
        ],
      ),
    );
  }
}
