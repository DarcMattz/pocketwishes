import 'package:flutter/material.dart';
import 'screens/add_wish_screen.dart';
import 'screens/wishlist_screen.dart';

void main() {
  runApp(PocketWishesApp());
}

class PocketWishesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PocketWishes',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: WishlistScreen(),
      routes: {
        '/add': (_) => AddWishScreen(),
      },
    );
  }
}
