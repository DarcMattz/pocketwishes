import 'dart:io';
import 'package:flutter/material.dart';
import '../models/wish.dart';
import '../helpers/wish_storage.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<Wish> _wishes = [];

  @override
  void initState() {
    super.initState();
    _loadWishes();
  }

  Future<void> _loadWishes() async {
    final wishes = await WishStorage.loadWishes();
    setState(() => _wishes = wishes);
  }

  Future<void> _toggleFulfilled(Wish wish) async {
    setState(() => wish.isFulfilled = !wish.isFulfilled);
    await WishStorage.saveWishes(_wishes);
  }

  Future<void> _deleteWish(Wish wish) async {
    setState(() => _wishes.removeWhere((w) => w.id == wish.id));
    await WishStorage.saveWishes(_wishes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PocketWishes")),
      body: _wishes.isEmpty
          ? Center(child: Text("No wishes yet. Tap + to add one."))
          : ListView.builder(
              itemCount: _wishes.length,
              itemBuilder: (ctx, i) {
                final wish = _wishes[i];
                return Card(
                  child: ListTile(
                    leading: wish.imagePath != null
                        ? Image.file(File(wish.imagePath!),
                            width: 50, height: 50)
                        : Icon(Icons.favorite_border),
                    title: Text(
                      wish.title,
                      style: TextStyle(
                        decoration: wish.isFulfilled
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text("${wish.description}\n₱${wish.price}"),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            wish.isFulfilled
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                          onPressed: () => _toggleFulfilled(wish),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteWish(wish),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          _loadWishes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
